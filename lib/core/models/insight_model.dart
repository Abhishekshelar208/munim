class InsightModel {
  final String id;
  final String title;
  final String description;
  final double currentValue;
  final double futureValue5y;
  final double futureValue10y;
  final double futureValue20y;
  final double inflationAdjusted;
  final String emoji;
  final String category;

  const InsightModel({
    required this.id,
    required this.title,
    required this.description,
    required this.currentValue,
    required this.futureValue5y,
    required this.futureValue10y,
    required this.futureValue20y,
    required this.inflationAdjusted,
    required this.emoji,
    required this.category,
  });

  double futureValueAt(int years) {
    switch (years) {
      case 5:  return futureValue5y;
      case 10: return futureValue10y;
      case 20: return futureValue20y;
      default: return futureValue5y;
    }
  }

  double get multiplier20y => currentValue == 0 ? 0 : futureValue20y / currentValue;
}

class AdvisorMessage {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final AdvisorMessageType type;

  const AdvisorMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.type = AdvisorMessageType.text,
  });
}

enum AdvisorMessageType { text, comparison, alert, tip }
