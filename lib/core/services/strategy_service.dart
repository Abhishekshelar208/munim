import '../models/transaction_model.dart';
import '../models/goal_model.dart';
import '../models/behavior_prediction.dart';
import 'ml_service.dart';
import 'finance_service.dart';

class WealthRule {
  final String emoji;
  final String title;
  final String description;
  final bool isStrict;

  const WealthRule(this.emoji, this.title, this.description, {this.isStrict = false});
}

class StrategyService {
  StrategyService._();
  static final StrategyService instance = StrategyService._();

  /// Modifies the standard 50-30-20 rule dynamically based on ML prediction of recent behavior
  MoneyAllocation generateDynamicAllocation(double monthlyIncome, List<TransactionModel> monthTransactions) {
    if (monthlyIncome <= 0) return const MoneyAllocation(needs: 0, investSave: 0, wants: 0);

    // Let's analyze behavior via ML
    int poorChoices = 0;
    int goodChoices = 0;
    
    for (var t in monthTransactions) {
      final pred = MLService.instance.predictBehavior(
        amount: t.amount,
        category: t.category,
        monthlyIncome: monthlyIncome,
        date: t.date,
        monthlyTransactionCount: monthTransactions.length,
      );
      if (pred.label == BehaviorLabel.poor) poorChoices++;
      if (pred.label == BehaviorLabel.good) goodChoices++;
    }

    // Dynamic adjustment
    if (poorChoices > goodChoices) {
      // Impulsive Spender -> Lock down discretionary, force savings
      return MoneyAllocation(
        needs: monthlyIncome * 0.55,
        investSave: monthlyIncome * 0.35,
        wants: monthlyIncome * 0.10,
      );
    } else if (goodChoices > 0 && poorChoices == 0) {
      // Highly Disciplined -> Can relax needs or increase aggressive investments
      return MoneyAllocation(
        needs: monthlyIncome * 0.40,
        investSave: monthlyIncome * 0.40,
        wants: monthlyIncome * 0.20,
      );
    }
    
    // Default Fallback
    return MoneyAllocation(
      needs: monthlyIncome * 0.50,
      investSave: monthlyIncome * 0.30,
      wants: monthlyIncome * 0.20,
    );
  }

  /// Replaces hardcoded Goal presets with dynamic goals based on income
  List<GoalModel> generatePersonalizedGoals(double monthlyIncome) {
    if (monthlyIncome <= 0) return GoalModel.presets();

    final emFundTarget = monthlyIncome * 3;
    final wealthTarget = monthlyIncome * 12; // 1 year salary 

    return [
      GoalModel(
        id: 'em_fund',
        title: 'Bulletproof Fund',
        emoji: '🛡️',
        targetAmount: emFundTarget,
        currentAmount: 0,
        deadline: DateTime.now().add(const Duration(days: 180)),
        description: 'Emergency Fund',
      ),
      GoalModel(
        id: 'wealth_milestone',
        title: '1-Year Freedom',
        emoji: '🦅',
        targetAmount: wealthTarget,
        currentAmount: 0,
        deadline: DateTime.now().add(const Duration(days: 365 * 2)), // 2 years
        description: 'Wealth Building',
      ),
    ];
  }

  /// Dynamic Wealth rules based on recent transactions
  List<WealthRule> generateWealthRules(List<TransactionModel> transactions) {
     if (transactions.isEmpty) {
       return const [
         WealthRule('🌱', 'Start Tracking', 'Log your first expense to generate AI insights.'),
         WealthRule('💳', 'Avoid High EMI', 'Do not exceed 30% of your income in fixed EMIs.'),
       ];
     }

     final largeExpenses = transactions.where((t) => t.type == TransactionType.expense && t.amount > 5000).toList();
     final hasInvestments = transactions.any((t) => t.category.isInvestment);

     List<WealthRule> rules = [];

     if (largeExpenses.isNotEmpty) {
        rules.add(const WealthRule('🚨', '48-Hour Rule', 'You frequently make large purchases. Wait 48 hours before any expense above ₹5,000.', isStrict: true));
     } else {
        rules.add(const WealthRule('✅', 'Sustained Discipline', 'Your spending is highly controlled. Maintain this low burn-rate.'));
     }

     if (!hasInvestments) {
        rules.add(const WealthRule('📉', 'Cash Drag', 'Your money is losing value to inflation. Immediately start parking 20% in Index Funds.', isStrict: true));
     } else {
        rules.add(const WealthRule(' compounding', 'Don\'t Interrupt Compounding', 'You have active investments. Never withdraw them for consumption.'));
     }

     rules.add(const WealthRule('🔄', 'Automate Wealth', 'Set up auto-debit on salary day so you invest before you spend.'));

     return rules;
  }
}
