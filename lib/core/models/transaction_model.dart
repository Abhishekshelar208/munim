enum TransactionType { income, expense, investment, saving }

enum TransactionCategory {
  // Income
  salary, freelance, business, gift, other,
  // Expenses — Essential
  food, rent, transport, utilities, healthcare, education,
  // Expenses — Discretionary
  entertainment, shopping, dining, subscription, travel,
  // Investment
  stocks, mutualFunds, crypto, gold, realEstate,
  // Savings
  emergencyFund, fixedDeposit, rd,
}

enum RoiLabel { excellent, good, neutral, poor, terrible }

extension TransactionCategoryExt on TransactionCategory {
  bool get isEssential => [
    TransactionCategory.food,
    TransactionCategory.rent,
    TransactionCategory.transport,
    TransactionCategory.utilities,
    TransactionCategory.healthcare,
    TransactionCategory.education,
  ].contains(this);

  bool get isInvestment => [
    TransactionCategory.stocks,
    TransactionCategory.mutualFunds,
    TransactionCategory.crypto,
    TransactionCategory.gold,
    TransactionCategory.realEstate,
  ].contains(this);

  String get displayName {
    switch (this) {
      case TransactionCategory.salary: return 'Salary';
      case TransactionCategory.freelance: return 'Freelance';
      case TransactionCategory.business: return 'Business';
      case TransactionCategory.gift: return 'Gift';
      case TransactionCategory.food: return 'Food';
      case TransactionCategory.rent: return 'Rent';
      case TransactionCategory.transport: return 'Transport';
      case TransactionCategory.utilities: return 'Utilities';
      case TransactionCategory.healthcare: return 'Healthcare';
      case TransactionCategory.education: return 'Education';
      case TransactionCategory.entertainment: return 'Entertainment';
      case TransactionCategory.shopping: return 'Shopping';
      case TransactionCategory.dining: return 'Dining Out';
      case TransactionCategory.subscription: return 'Subscription';
      case TransactionCategory.travel: return 'Travel';
      case TransactionCategory.stocks: return 'Stocks';
      case TransactionCategory.mutualFunds: return 'Mutual Funds';
      case TransactionCategory.crypto: return 'Crypto';
      case TransactionCategory.gold: return 'Gold';
      case TransactionCategory.realEstate: return 'Real Estate';
      case TransactionCategory.emergencyFund: return 'Emergency Fund';
      case TransactionCategory.fixedDeposit: return 'Fixed Deposit';
      case TransactionCategory.rd: return 'RD';
      default: return 'Other';
    }
  }
}

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final TransactionCategory category;
  final RoiLabel roiLabel;
  final DateTime date;
  final String? note;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.roiLabel,
    required this.date,
    this.note,
  });

  bool get isPositive =>
      type == TransactionType.income ||
      type == TransactionType.investment ||
      type == TransactionType.saving;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'type': type.index,
    'category': category.index,
    'roiLabel': roiLabel.index,
    'date': date.toIso8601String(),
    'note': note,
  };

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'] as String,
        title: json['title'] as String,
        amount: (json['amount'] as num).toDouble(),
        type: TransactionType.values[json['type'] as int],
        category: TransactionCategory.values[json['category'] as int],
        roiLabel: RoiLabel.values[json['roiLabel'] as int],
        date: DateTime.parse(json['date'] as String),
        note: json['note'] as String?,
      );
}
