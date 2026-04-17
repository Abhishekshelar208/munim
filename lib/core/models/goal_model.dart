class GoalModel {
  final String id;
  final String title;
  final String emoji;
  final double targetAmount;
  final double currentAmount;
  final DateTime deadline;
  final String? description;

  const GoalModel({
    required this.id,
    required this.title,
    required this.emoji,
    required this.targetAmount,
    required this.currentAmount,
    required this.deadline,
    this.description,
  });

  double get progressPercent =>
      targetAmount == 0 ? 0 : (currentAmount / targetAmount).clamp(0, 1);

  double get remaining => (targetAmount - currentAmount).clamp(0, double.infinity);

  int get daysLeft => deadline.difference(DateTime.now()).inDays;

  bool get isCompleted => currentAmount >= targetAmount;

  GoalModel copyWith({
    String? id,
    String? title,
    String? emoji,
    double? targetAmount,
    double? currentAmount,
    DateTime? deadline,
    String? description,
  }) =>
      GoalModel(
        id: id ?? this.id,
        title: title ?? this.title,
        emoji: emoji ?? this.emoji,
        targetAmount: targetAmount ?? this.targetAmount,
        currentAmount: currentAmount ?? this.currentAmount,
        deadline: deadline ?? this.deadline,
        description: description ?? this.description,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'emoji': emoji,
    'targetAmount': targetAmount,
    'currentAmount': currentAmount,
    'deadline': deadline.toIso8601String(),
    'description': description,
  };

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
    id: json['id'] as String,
    title: json['title'] as String,
    emoji: json['emoji'] as String,
    targetAmount: (json['targetAmount'] as num).toDouble(),
    currentAmount: (json['currentAmount'] as num).toDouble(),
    deadline: DateTime.parse(json['deadline'] as String),
    description: json['description'] as String?,
  );

  static List<GoalModel> presets() => [
    GoalModel(
      id: 'emergency',
      title: 'Emergency Fund',
      emoji: '🛡️',
      targetAmount: 50000,
      currentAmount: 0,
      deadline: DateTime.now().add(const Duration(days: 180)),
      description: '6 months of expenses as safety net',
    ),
    GoalModel(
      id: 'investment',
      title: 'Start Investing',
      emoji: '📈',
      targetAmount: 10000,
      currentAmount: 0,
      deadline: DateTime.now().add(const Duration(days: 90)),
      description: 'First SIP or stock investment',
    ),
    GoalModel(
      id: 'gadget',
      title: 'New Laptop',
      emoji: '💻',
      targetAmount: 80000,
      currentAmount: 0,
      deadline: DateTime.now().add(const Duration(days: 365)),
      description: 'Save before buying, not EMI',
    ),
  ];
}
