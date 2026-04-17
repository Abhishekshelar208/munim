enum BehaviorLabel {
  good,
  neutral,
  poor,
}

class BehaviorPrediction {
  final BehaviorLabel label;
  final String reason;

  const BehaviorPrediction({
    required this.label,
    required this.reason,
  });

  Map<String, dynamic> toJson() => {
    'label': label.index,
    'reason': reason,
  };

  factory BehaviorPrediction.fromJson(Map<String, dynamic> json) =>
      BehaviorPrediction(
        label: BehaviorLabel.values[json['label'] as int],
        reason: json['reason'] as String,
      );
}
