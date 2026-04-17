import '../models/transaction_model.dart';
import 'package:collection/collection.dart';

class FutureScenario {
  final String emoji;
  final String label;
  final double monthlyAmount;
  final String description;
  final bool isPositive;

  const FutureScenario({
    required this.emoji,
    required this.label,
    required this.monthlyAmount,
    required this.description,
    this.isPositive = false,
  });
}

class FutureProjections {
  final double assumedReturnRate; // 0.12 = 12%
  final double assumedInflation; // 0.06 = 6%

  const FutureProjections({
    required this.assumedReturnRate,
    required this.assumedInflation,
  });
}

class FutureService {
  FutureService._();
  static final FutureService instance = FutureService._();

  /// Dynamically predict market parameters based on user's investment quality
  FutureProjections predictDynamicRates(List<TransactionModel> transactions) {
     if (transactions.isEmpty) {
       return const FutureProjections(assumedReturnRate: 0.10, assumedInflation: 0.07);
     }

     // If they invest in High Equity (Stocks/Crypto), assumed rate goes up to 14%. 
     // If they only do Fixed Deposits/RD, assumed rate is safely 7%.
     double equityInv = 0.0;
     double safeInv = 0.0;

     for (var t in transactions.where((t) => t.category.isInvestment)) {
        if (t.category == TransactionCategory.stocks || t.category == TransactionCategory.mutualFunds || t.category == TransactionCategory.crypto) {
           equityInv += t.amount;
        } else {
           safeInv += t.amount;
        }
     }

     double rate = 0.10; // Default blended
     if (equityInv > 0 && equityInv > safeInv) {
        rate = 0.14; // Aggressive projection
     } else if (safeInv > 0 && safeInv > equityInv) {
        rate = 0.07; // Conservative projection
     }

     // Inflation is generally static, but we'll assume 6.5%
     return FutureProjections(assumedReturnRate: rate, assumedInflation: 0.065);
  }

  /// Analyze actual transactions and pull the highest frequent categories to build scenarios
  List<FutureScenario> extractRealScenarios(List<TransactionModel> transactions, double monthlyIncome) {
      if (transactions.isEmpty) {
          // Fallback intelligently calculated on income
          final sipAmount = monthlyIncome * 0.10;
          return [
             FutureScenario(emoji: '📈', label: 'SIP Compounding', monthlyAmount: sipAmount, description: 'Invest just 10% of your income into an Index SIP.', isPositive: true),
             FutureScenario(emoji: '☕', label: 'Coffee Habit', monthlyAmount: monthlyIncome * 0.02, description: 'Daily coffee expense compounded over time limits your growth.'),
          ];
      }

      final expenseByCategory = <TransactionCategory, double>{};
      for (var t in transactions.where((t) => t.type == TransactionType.expense && !t.category.isEssential)) {
          expenseByCategory[t.category] = (expenseByCategory[t.category] ?? 0.0) + t.amount;
      }

      var sortedCategories = expenseByCategory.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      
      final scenarios = <FutureScenario>[];

      // Good Scenario
      double totalInv = transactions.where((t) => t.category.isInvestment).fold(0.0, (s, t) => s + t.amount);
      if (totalInv > 0) {
        scenarios.add(FutureScenario(emoji: '📈', label: 'Your Actual Investments', monthlyAmount: totalInv, description: 'You are currently investing this amount. See what it becomes.', isPositive: true));
      } else {
        scenarios.add(FutureScenario(emoji: '💰', label: 'Start 10% SIP', monthlyAmount: monthlyIncome * 0.10, description: 'Imagine you started an Index SIP today.', isPositive: true));
      }

      // Add top 3 poor scenarios
      for (var entry in sortedCategories.take(3)) {
         if (entry.value < 500) continue; // Skip negligible
         scenarios.add(FutureScenario(
            emoji: entry.key == TransactionCategory.food || entry.key == TransactionCategory.dining ? '🍕' : '🛍️',
            label: '${entry.key.displayName} Trap',
            monthlyAmount: entry.value,
            description: 'You spent heavily on ${entry.key.displayName} this month. See the unseen opportunity cost.',
            isPositive: false,
         ));
      }

      if (scenarios.length == 1) {
         scenarios.add(const FutureScenario(emoji: '💸', label: 'General Leaks', monthlyAmount: 1000, description: 'Miscellaneous untracked expenses compound too.'));
      }

      return scenarios;
  }
}
