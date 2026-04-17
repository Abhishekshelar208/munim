import 'dart:math';

import '../models/transaction_model.dart';

class FinanceService {
  FinanceService._();
  static final FinanceService instance = FinanceService._();

  // ── Net profit calculation ────────────────────────────────────────────────
  double calculateNetProfit({
    required double monthlyIncome,
    required List<TransactionModel> transactions,
  }) {
    final totalExpenses = transactions
        .where((t) =>
            t.type == TransactionType.expense &&
            DateTime.now().month == t.date.month &&
            DateTime.now().year == t.date.year)
        .fold(0.0, (sum, t) => sum + t.amount);

    return monthlyIncome - totalExpenses;
  }

  // ── Days of Freedom ───────────────────────────────────────────────────────
  int calculateDaysOfFreedom({
    required double totalSavings,
    required double monthlyEssentialExpenses,
  }) {
    if (monthlyEssentialExpenses == 0) return 0;
    final dailyExpense = monthlyEssentialExpenses / 30;
    return (totalSavings / dailyExpense).floor();
  }

  // ── Total Assets / Liabilities ────────────────────────────────────────────
  double calculateTotalAssets(List<TransactionModel> transactions) {
    return transactions
        .where((t) =>
            t.type == TransactionType.investment ||
            t.type == TransactionType.saving)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double calculateTotalLiabilities(List<TransactionModel> transactions) {
    return transactions
        .where((t) =>
            t.type == TransactionType.expense &&
            !t.category.isEssential)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  // ── Future Value (compound interest) ─────────────────────────────────────
  double futureValue(double presentValue, {int years = 10, double rate = 0.12}) {
    return presentValue * pow(1 + rate, years);
  }

  /// What ₹X spent today would have become if invested
  double opportunityCost(double amount, {int years = 10}) {
    return futureValue(amount, years: years, rate: 0.12);
  }

  // ── Monthly recommended allocation ───────────────────────────────────────
  MoneyAllocation recommendAllocation(double monthlyIncome) {
    // 50-30-20 adapted for freshers: 50% needs, 30% invest+save, 20% wants
    return MoneyAllocation(
      needs: monthlyIncome * 0.50,
      investSave: monthlyIncome * 0.30,
      wants: monthlyIncome * 0.20,
    );
  }

  // ── ROI label scoring ─────────────────────────────────────────────────────
  RoiLabel scoreTransaction(TransactionModel t) {
    if (t.type == TransactionType.investment) return RoiLabel.excellent;
    if (t.type == TransactionType.saving) return RoiLabel.good;
    if (t.category.isEssential) return RoiLabel.neutral;
    if (t.category == TransactionCategory.education) return RoiLabel.good;
    if ([
      TransactionCategory.entertainment,
      TransactionCategory.dining,
      TransactionCategory.shopping,
    ].contains(t.category)) {
      if (t.amount > 2000) return RoiLabel.poor;
      return RoiLabel.neutral;
    }
    if (t.category == TransactionCategory.subscription && t.amount > 1000) {
      return RoiLabel.poor;
    }
    return RoiLabel.neutral;
  }

  // ── Inflation adjusted value ──────────────────────────────────────────────
  double inflationAdjusted(double amount, {int years = 10, double inflation = 0.06}) {
    return amount / pow(1 + inflation, years);
  }

  // ── Smart alerts ──────────────────────────────────────────────────────────
  List<SmartAlert> generateAlerts({
    required double monthlyIncome,
    required List<TransactionModel> transactions,
    required double totalSavings,
  }) {
    final alerts = <SmartAlert>[];
    final monthExpenses = transactions
        .where((t) =>
            t.type == TransactionType.expense &&
            t.date.month == DateTime.now().month)
        .fold(0.0, (s, t) => s + t.amount);

    final investmentTotal = transactions
        .where((t) => t.type == TransactionType.investment)
        .fold(0.0, (s, t) => s + t.amount);

    if (monthExpenses > monthlyIncome * 0.8) {
      alerts.add(SmartAlert(
        type: AlertType.danger,
        title: 'High Burn Rate',
        message: 'You\'ve spent ${((monthExpenses / monthlyIncome) * 100).toStringAsFixed(0)}% of your income this month.',
        emoji: '🔴',
      ));
    }

    if (investmentTotal == 0 && monthlyIncome > 0) {
      alerts.add(SmartAlert(
        type: AlertType.tip,
        title: 'Start Investing Today',
        message: 'Even ₹500/month in index funds compounds to ₹${(opportunityCost(500 * 12, years: 20) / 100000).toStringAsFixed(1)}L in 20 years.',
        emoji: '📈',
      ));
    }

    if (totalSavings < monthlyIncome * 3) {
      alerts.add(SmartAlert(
        type: AlertType.warning,
        title: 'Emergency Fund Gap',
        message: 'You should hold at least 3 months of income (₹${(monthlyIncome * 3).toStringAsFixed(0)}) as emergency reserve.',
        emoji: '🛡️',
      ));
    }

    return alerts;
  }
}

class MoneyAllocation {
  final double needs;
  final double investSave;
  final double wants;

  const MoneyAllocation({
    required this.needs,
    required this.investSave,
    required this.wants,
  });

  double get total => needs + investSave + wants;
}

class SmartAlert {
  final AlertType type;
  final String title;
  final String message;
  final String emoji;

  const SmartAlert({
    required this.type,
    required this.title,
    required this.message,
    required this.emoji,
  });
}

enum AlertType { danger, warning, tip, info }
