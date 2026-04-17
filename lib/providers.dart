import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../core/models/user_model.dart';
import '../core/models/transaction_model.dart';
import '../core/models/goal_model.dart';
import '../core/models/insight_model.dart';
import '../core/services/finance_service.dart';
import '../core/services/storage_service.dart';
import '../core/services/ai_service.dart';
import '../core/localization/app_localizations.dart';
import '../core/services/ml_service.dart';

// ─────────────────────────────────────────────────────────────────────────────
// UserProvider
// ─────────────────────────────────────────────────────────────────────────────
class UserProvider extends ChangeNotifier {
  final StorageService _storage;
  UserModel _user = UserModel.empty();
  bool _loading = true;

  UserProvider(this._storage);

  UserModel get user => _user;
  bool get loading => _loading;
  bool get isOnboarded => _user.onboardingComplete;

  Future<void> init() async {
    final saved = await _storage.loadUser();
    if (saved != null) _user = saved;
    _loading = false;
    notifyListeners();
  }

  Future<void> saveUser(UserModel u) async {
    _user = u;
    await _storage.saveUser(u);
    notifyListeners();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TransactionProvider
// ─────────────────────────────────────────────────────────────────────────────
class TransactionProvider extends ChangeNotifier {
  final StorageService _storage;
  final _uuid = const Uuid();

  List<TransactionModel> _transactions = [];
  double _totalSavings = 0;

  TransactionProvider(this._storage);

  List<TransactionModel> get transactions => List.unmodifiable(_transactions);
  double get totalSavings => _totalSavings;

  List<TransactionModel> get thisMonthTransactions => _transactions.where((t) {
    final now = DateTime.now();
    return t.date.month == now.month && t.date.year == now.year;
  }).toList();

  double get thisMonthExpenses => thisMonthTransactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0.0, (s, t) => s + t.amount);

  double get thisMonthInvestments => thisMonthTransactions
      .where((t) => t.type == TransactionType.investment)
      .fold(0.0, (s, t) => s + t.amount);

  double netProfit(double monthlyIncome) =>
      FinanceService.instance.calculateNetProfit(
        monthlyIncome: monthlyIncome,
        transactions: _transactions,
      );

  Future<void> init() async {
    _transactions = await _storage.loadTransactions();
    _totalSavings = await _storage.loadTotalSavings();
    notifyListeners();
  }

  Future<void> addTransaction({
    required String title,
    required double amount,
    required TransactionType type,
    required TransactionCategory category,
    required double monthlyIncome,
    String? note,
  }) async {
    final now = DateTime.now();
    final prediction = MLService.instance.predictBehavior(
      amount: amount,
      category: category,
      monthlyIncome: monthlyIncome,
      date: now,
      monthlyTransactionCount: thisMonthTransactions.length,
    );

    final t = TransactionModel(
      id: _uuid.v4(),
      title: title,
      amount: amount,
      type: type,
      category: category,
      roiLabel: FinanceService.instance.scoreTransaction(
        TransactionModel(
          id: '',
          title: title,
          amount: amount,
          type: type,
          category: category,
          roiLabel: RoiLabel.neutral,
          date: now,
        ),
      ),
      behaviorPrediction: prediction,
      date: now,
      note: note,
    );

    _transactions.insert(0, t);

    if (type == TransactionType.saving) {
      _totalSavings += amount;
      await _storage.saveTotalSavings(_totalSavings);
    }

    await _storage.saveTransactions(_transactions);
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    final t = _transactions.firstWhere((t) => t.id == id);
    if (t.type == TransactionType.saving) {
      _totalSavings = (_totalSavings - t.amount).clamp(0, double.infinity);
      await _storage.saveTotalSavings(_totalSavings);
    }
    _transactions.removeWhere((t) => t.id == id);
    await _storage.saveTransactions(_transactions);
    notifyListeners();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GoalProvider
// ─────────────────────────────────────────────────────────────────────────────
class GoalProvider extends ChangeNotifier {
  final StorageService _storage;
  List<GoalModel> _goals = [];

  GoalProvider(this._storage);

  List<GoalModel> get goals => List.unmodifiable(_goals);

  Future<void> init() async {
    _goals = await _storage.loadGoals();
    notifyListeners();
  }

  Future<void> addGoal(GoalModel goal) async {
    _goals.add(goal);
    await _storage.saveGoals(_goals);
    notifyListeners();
  }

  Future<void> updateProgress(String id, double amount) async {
    final index = _goals.indexWhere((g) => g.id == id);
    if (index == -1) return;
    _goals[index] = _goals[index].copyWith(
      currentAmount: (_goals[index].currentAmount + amount)
          .clamp(0, _goals[index].targetAmount),
    );
    await _storage.saveGoals(_goals);
    notifyListeners();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AdvisorProvider
// ─────────────────────────────────────────────────────────────────────────────
class AdvisorProvider extends ChangeNotifier {
  final List<AdvisorMessage> _messages = [];
  bool _loading = false;

  List<AdvisorMessage> get messages => List.unmodifiable(_messages);
  bool get loading => _loading;

  AdvisorProvider() {
    _addWelcome();
  }

  void _addWelcome() {
    _messages.add(AdvisorMessage(
      id: '0',
      content: '👋 Hi! I\'m MUNI, your financial advisor. Ask me anything — how to save, invest, or whether a purchase is worth it. I\'ll give you straight, honest Indian-context advice.',
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  Future<void> sendMessage(String text, {Map<String, dynamic>? context}) async {
    _messages.add(AdvisorMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));
    _loading = true;
    notifyListeners();

    final response = await AIService.instance.sendMessage(text, userContext: context);
    _messages.add(response);
    _loading = false;
    notifyListeners();
  }

  void clear() {
    _messages.clear();
    _addWelcome();
    notifyListeners();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ThemeProvider
// ─────────────────────────────────────────────────────────────────────────────
class ThemeProvider extends ChangeNotifier {
  final StorageService _storage;
  ThemeMode _themeMode = ThemeMode.light;

  ThemeProvider(this._storage);

  ThemeMode get themeMode => _themeMode;

  Future<void> init() async {
    final saved = await _storage.loadThemeMode();
    _themeMode = saved;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _storage.saveThemeMode(mode);
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LanguageProvider
// ─────────────────────────────────────────────────────────────────────────────
class LanguageProvider extends ChangeNotifier {
  final StorageService _storage;
  Locale _locale = const Locale('en');

  LanguageProvider(this._storage);

  Locale get locale => _locale;
  String get languageCode => _locale.languageCode;

  static List<Locale> get supportedLocales =>
      AppLocalizations.supportedLocales;

  Future<void> init() async {
    final saved = await _storage.loadLanguageCode();
    _locale = Locale(saved);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await _storage.saveLanguageCode(locale.languageCode);
    notifyListeners();
  }
}
