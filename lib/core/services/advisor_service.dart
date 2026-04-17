import 'package:uuid/uuid.dart';
import '../models/insight_model.dart';
import '../models/transaction_model.dart';
import '../models/behavior_prediction.dart';

class AdvisorService {
  AdvisorService._();
  static final AdvisorService instance = AdvisorService._();

  final _uuid = const Uuid();

  /// Analyzes the user's financial state and returns a structured AdvisorMessage.
  AdvisorMessage analyzeState({
    required double monthlyIncome,
    required double monthlyExpenses,
    required double totalSavings,
    required double totalInvestments,
    required TransactionModel? latestTransaction,
  }) {
    final now = DateTime.now();
    final expenseRatio = monthlyIncome > 0 ? monthlyExpenses / monthlyIncome : 0.0;
    final savingsRatio = monthlyIncome > 0 ? totalSavings / monthlyIncome : 0.0;

    // 1. High Burn Rate Alert
    if (expenseRatio > 0.70) {
      return AdvisorMessage(
        id: _uuid.v4(),
        isUser: false,
        timestamp: now,
        type: AdvisorMessageType.alert,
        content: '⚠️ You are overspending this month.',
        reason: 'Your expenses have exceeded ${(expenseRatio * 100).toStringAsFixed(0)}% of your monthly income.',
        actionSuggestion: 'Review recent transactions and cut non-essential expenses immediately.',
      );
    }

    // 2. Poor ML Spending Alert (Check latest transaction if recent)
    if (latestTransaction != null &&
        latestTransaction.date.isAfter(now.subtract(const Duration(days: 2))) &&
        latestTransaction.behaviorPrediction?.label == BehaviorLabel.poor) {
      return AdvisorMessage(
        id: _uuid.v4(),
        isUser: false,
        timestamp: now,
        type: AdvisorMessageType.alert,
        content: '🔴 This is high-risk spending.',
        reason: latestTransaction.behaviorPrediction!.reason,
        actionSuggestion: 'Try to reduce the frequency of such purchases or delay them to weekends.',
      );
    }

    // 3. Idle Money Alert
    if (savingsRatio > 0.20 && totalInvestments == 0) {
      return AdvisorMessage(
        id: _uuid.v4(),
        isUser: false,
        timestamp: now,
        type: AdvisorMessageType.tip,
        content: '💡 Your money is idle.',
        reason: 'You have good savings but no active investments. Inflation will erode this value.',
        actionSuggestion: 'Start a SIP in an Index Mutual Fund with just ₹500/month.',
      );
    }

    // 4. Good Behavior Reinforcement
    if (latestTransaction != null &&
        latestTransaction.date.isAfter(now.subtract(const Duration(days: 2))) &&
        latestTransaction.behaviorPrediction?.label == BehaviorLabel.good) {
      return AdvisorMessage(
        id: _uuid.v4(),
        isUser: false,
        timestamp: now,
        type: AdvisorMessageType.text,
        content: '✅ Great financial decision!',
        reason: latestTransaction.behaviorPrediction!.reason,
        actionSuggestion: 'Continue this discipline to build long-term wealth.',
      );
    }

    // 5. Default Fallback / Health Check
    return AdvisorMessage(
      id: _uuid.v4(),
      isUser: false,
      timestamp: now,
      type: AdvisorMessageType.text,
      content: '📊 Your financial health looks stable.',
      reason: 'You are within standard spending boundaries. Make sure you stick to the 50/30/20 rule.',
      actionSuggestion: 'Check your Future Insights tab to see your projected growth.',
    );
  }

  /// Generates a simple text response if the user just says "hello" or asks a random question.
  /// Eventually this could route to an LLM, but for now we keep it structured.
  AdvisorMessage getFallbackResponse(String query) {
    return AdvisorMessage(
      id: _uuid.v4(),
      isUser: false,
      timestamp: DateTime.now(),
      type: AdvisorMessageType.text,
      content: 'I am your hybrid financial advisor. Tap "Analyze my finances" or ask a structured prompt to get a full diagnostic of your behavior and spending.',
    );
  }
}
