import '../models/transaction_model.dart';

enum GrowthTrend { up, down, stable }

class GrowthMetrics {
  final double currentSavings;
  final double previousSavings;
  final double growthPercentage;
  final GrowthTrend trend;
  final String insight;

  GrowthMetrics({
    required this.currentSavings,
    required this.previousSavings,
    required this.growthPercentage,
    required this.trend,
    required this.insight,
  });
}

class GrowthService {
  GrowthService._();
  static final GrowthService instance = GrowthService._();

  GrowthMetrics calculateGrowth(List<TransactionModel> transactions) {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    // Previous month logic
    var prevMonth = currentMonth - 1;
    var prevYear = currentYear;
    if (prevMonth == 0) {
      prevMonth = 12;
      prevYear--;
    }

    double currentSavings = 0;
    double previousSavings = 0;

    for (var tx in transactions) {
      if (tx.type == TransactionType.saving || tx.type == TransactionType.investment) {
        if (tx.date.year == currentYear && tx.date.month == currentMonth) {
          currentSavings += tx.amount;
        } else if (tx.date.year == prevYear && tx.date.month == prevMonth) {
          previousSavings += tx.amount;
        }
      }
    }

    double growthPercentage = 0;
    GrowthTrend trend = GrowthTrend.stable;
    String insight = '';

    if (previousSavings == 0) {
      if (currentSavings > 0) {
        trend = GrowthTrend.up;
        growthPercentage = 100.0;
        insight = 'Great start! You began saving this month. Keep building on this momentum.';
      } else {
        trend = GrowthTrend.stable;
        insight = 'You haven\'t started saving recently. Any amount today builds your future.';
      }
    } else {
      growthPercentage = ((currentSavings - previousSavings) / previousSavings) * 100;
      if (growthPercentage > 0) {
        trend = GrowthTrend.up;
        insight = 'You are improving your financial discipline! Try to maintain this trajectory.';
      } else if (growthPercentage < 0) {
        trend = GrowthTrend.down;
        insight = 'Your savings dipped this month. Time to review your expenses and recover.';
      } else {
        trend = GrowthTrend.stable;
        insight = 'Your savings are holding steady. Consistency is key.';
      }
    }

    return GrowthMetrics(
      currentSavings: currentSavings,
      previousSavings: previousSavings,
      growthPercentage: growthPercentage,
      trend: trend,
      insight: insight,
    );
  }
}
