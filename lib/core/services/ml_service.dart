import '../models/transaction_model.dart';
import '../models/behavior_prediction.dart';

class MLService {
  MLService._();
  static final MLService instance = MLService._();

  /// Simulates an ML prediction based on the Python-trained model (mindset_model.pkl).
  /// Features used: amount, category, frequency, income_ratio, time_of_day, day_type
  BehaviorPrediction predictBehavior({
    required double amount,
    required TransactionCategory category,
    required double monthlyIncome,
    required DateTime date,
    required int monthlyTransactionCount,
  }) {
    // 1. Derive features
    final timeOfDay = _getTimeOfDay(date);
    final dayType = _getDayType(date);
    final incomeRatio = monthlyIncome > 0 ? amount / monthlyIncome : 0.0;
    
    // We proxy frequency with the monthlyTransactionCount. If it's very high,
    // they are making many impulsive small purchases.
    final isHighFrequency = monthlyTransactionCount > 30;

    // 2. Logic Matrix (Approximating decision boundaries)

    // A) Investments & Savings -> Always Good
    if (category.isInvestment || category == TransactionCategory.emergencyFund || category == TransactionCategory.fixedDeposit || category == TransactionCategory.rd) {
      if (incomeRatio > 0.3) {
        return const BehaviorPrediction(
          label: BehaviorLabel.neutral,
          reason: 'Excellent habit, but ensure you have enough liquidity for daily needs.',
        );
      }
      return const BehaviorPrediction(
        label: BehaviorLabel.good,
        reason: 'Building future wealth. Great decision!',
      );
    }

    // B) Essential Expenses -> Generally Good unless severely over income
    if (category.isEssential) {
      if (incomeRatio > 0.4) {
        return const BehaviorPrediction(
          label: BehaviorLabel.poor,
          reason: 'Essential, but highly disproportionate to your income.',
        );
      }
      return const BehaviorPrediction(
        label: BehaviorLabel.good,
        reason: 'Necessary essential expense.',
      );
    }

    // C) Discretionary (Wants)
    // C1) Poor behavior mapping
    if (timeOfDay == _TimeOfDayFeature.night) {
      if (amount > 1000) {
        return const BehaviorPrediction(
          label: BehaviorLabel.poor,
          reason: 'Late-night impulse buying detected. High value discretionary.',
        );
      }
      return const BehaviorPrediction(
        label: BehaviorLabel.poor,
        reason: 'Late-night spending is often impulsive.',
      );
    }

    if (incomeRatio > 0.1) {
      return const BehaviorPrediction(
        label: BehaviorLabel.poor,
        reason: 'High expense compared to income on a non-essential.',
      );
    }

    if (isHighFrequency && dayType == _DayTypeFeature.weekday) {
       return const BehaviorPrediction(
        label: BehaviorLabel.poor,
        reason: 'High frequency of discretionary spending during weekdays.',
      );
    }

    // C2) Neutral behavior mapping
    if (dayType == _DayTypeFeature.weekend && amount <= 5000) {
      return const BehaviorPrediction(
        label: BehaviorLabel.neutral,
        reason: 'Standard weekend discretionary spending.',
      );
    }

    if (amount > 5000) {
       return const BehaviorPrediction(
        label: BehaviorLabel.neutral,
        reason: 'Large discretionary purchase. Proceed with caution.',
      );
    }

    // C3) Good behavior fallback
    return const BehaviorPrediction(
      label: BehaviorLabel.good,
      reason: 'Controlled discretionary spending.',
    );
  }

  _TimeOfDayFeature _getTimeOfDay(DateTime date) {
    final hour = date.hour;
    if (hour >= 6 && hour < 12) return _TimeOfDayFeature.morning;
    if (hour >= 12 && hour < 17) return _TimeOfDayFeature.afternoon;
    if (hour >= 17 && hour < 22) return _TimeOfDayFeature.evening;
    return _TimeOfDayFeature.night; // 22 to 6
  }

  _DayTypeFeature _getDayType(DateTime date) {
    final weekend = [DateTime.saturday, DateTime.sunday];
    if (weekend.contains(date.weekday)) return _DayTypeFeature.weekend;
    return _DayTypeFeature.weekday;
  }
}

enum _TimeOfDayFeature { morning, afternoon, evening, night }
enum _DayTypeFeature { weekday, weekend }
