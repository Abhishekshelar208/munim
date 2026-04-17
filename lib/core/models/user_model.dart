enum UserType { student, fresher, professional, entrepreneur }

enum IncomeRange {
  below15k('Below ₹15,000', 12000),
  range15to30k('₹15,000 – ₹30,000', 22500),
  range30to50k('₹30,000 – ₹50,000', 40000),
  range50kPlus('₹50,000+', 60000);

  const IncomeRange(this.label, this.midpoint);
  final String label;
  final double midpoint;
}

class UserModel {
  final String id;
  final String name;
  final UserType userType;
  final IncomeRange incomeRange;
  final double monthlyIncome;
  final double monthlySavingsTarget;
  final List<String> goals;
  final DateTime createdAt;
  final bool onboardingComplete;

  const UserModel({
    required this.id,
    required this.name,
    required this.userType,
    required this.incomeRange,
    required this.monthlyIncome,
    required this.monthlySavingsTarget,
    required this.goals,
    required this.createdAt,
    this.onboardingComplete = false,
  });

  UserModel copyWith({
    String? id,
    String? name,
    UserType? userType,
    IncomeRange? incomeRange,
    double? monthlyIncome,
    double? monthlySavingsTarget,
    List<String>? goals,
    DateTime? createdAt,
    bool? onboardingComplete,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userType: userType ?? this.userType,
      incomeRange: incomeRange ?? this.incomeRange,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      monthlySavingsTarget: monthlySavingsTarget ?? this.monthlySavingsTarget,
      goals: goals ?? this.goals,
      createdAt: createdAt ?? this.createdAt,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'userType': userType.index,
    'incomeRange': incomeRange.index,
    'monthlyIncome': monthlyIncome,
    'monthlySavingsTarget': monthlySavingsTarget,
    'goals': goals,
    'createdAt': createdAt.toIso8601String(),
    'onboardingComplete': onboardingComplete,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    name: json['name'] as String,
    userType: UserType.values[json['userType'] as int],
    incomeRange: IncomeRange.values[json['incomeRange'] as int],
    monthlyIncome: (json['monthlyIncome'] as num).toDouble(),
    monthlySavingsTarget: (json['monthlySavingsTarget'] as num).toDouble(),
    goals: List<String>.from(json['goals'] as List),
    createdAt: DateTime.parse(json['createdAt'] as String),
    onboardingComplete: json['onboardingComplete'] as bool? ?? false,
  );

  static UserModel empty() => UserModel(
    id: '',
    name: '',
    userType: UserType.fresher,
    incomeRange: IncomeRange.range15to30k,
    monthlyIncome: 0,
    monthlySavingsTarget: 0,
    goals: [],
    createdAt: DateTime.now(),
  );
}
