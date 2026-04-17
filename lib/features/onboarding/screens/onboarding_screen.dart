import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/user_model.dart';
import '../../../providers.dart';
import '../../main_shell.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _page = PageController();
  int _step = 0;

  // Step 1 — Who are you?
  UserType? _userType;

  // Step 2 — Income
  IncomeRange? _incomeRange;
  final _nameCtrl = TextEditingController();

  // Step 3 — Goals
  final Set<String> _selectedGoals = {};

  static const _goals = [
    '🛡️ Build emergency fund',
    '📈 Start investing',
    '💳 Get debt-free',
    '🏠 Save for a big goal',
    '📚 Financial education',
    '🚀 Build wealth long-term',
  ];

  @override
  void dispose() {
    _page.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_step < 2) {
      _page.animateToPage(
        _step + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _back() {
    if (_step > 0) {
      _page.animateToPage(
        _step - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finish() async {
    final user = UserModel(
      id: const Uuid().v4(),
      name: _nameCtrl.text.trim().isEmpty ? 'Friend' : _nameCtrl.text.trim(),
      userType: _userType ?? UserType.fresher,
      incomeRange: _incomeRange ?? IncomeRange.range15to30k,
      monthlyIncome: (_incomeRange ?? IncomeRange.range15to30k).midpoint,
      monthlySavingsTarget:
          (_incomeRange ?? IncomeRange.range15to30k).midpoint * 0.20,
      goals: _selectedGoals.toList(),
      createdAt: DateTime.now(),
      onboardingComplete: true,
    );

    await context.read<UserProvider>().saveUser(user);
    await context.read<TransactionProvider>().init();
    await context.read<GoalProvider>().init();

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const MainShell(),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDeep,
      body: SafeArea(
        child: Column(
          children: [
            // Progress
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                children: List.generate(3, (i) {
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 3,
                      margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: i <= _step
                            ? AppColors.primaryGradient
                            : null,
                        color: i > _step ? AppColors.bgCardAlt : null,
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Pages
            Expanded(
              child: PageView(
                controller: _page,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _step = i),
                children: [
                  _StepWho(selected: _userType, onSelect: (t) => setState(() => _userType = t)),
                  _StepIncome(
                    selected: _incomeRange,
                    nameCtrl: _nameCtrl,
                    onSelect: (r) => setState(() => _incomeRange = r),
                  ),
                  _StepGoals(
                    goals: _goals,
                    selected: _selectedGoals,
                    onToggle: (g) => setState(() {
                      if (_selectedGoals.contains(g)) {
                        _selectedGoals.remove(g);
                      } else {
                        _selectedGoals.add(g);
                      }
                    }),
                  ),
                ],
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: [
                  if (_step > 0)
                    GestureDetector(
                      onTap: _back,
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.bgCardAlt,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.bgGlassBorder),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 18, color: AppColors.textSecondary),
                      ),
                    ),
                  if (_step > 0) const SizedBox(width: 12),
                  Expanded(
                    child: _GradientButton(
                      onTap: _canProceed ? _next : null,
                      label: _step == 2 ? 'Start My Journey 🚀' : 'Continue',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _canProceed {
    if (_step == 0) return _userType != null;
    if (_step == 1) return _incomeRange != null;
    return _selectedGoals.isNotEmpty;
  }
}

// ─── Step 1: Who are you? ────────────────────────────────────────────────────
class _StepWho extends StatelessWidget {
  final UserType? selected;
  final ValueChanged<UserType> onSelect;

  const _StepWho({required this.selected, required this.onSelect});

  static const _types = [
    (UserType.student, '🎓', 'Student', 'Still in college'),
    (UserType.fresher, '💼', 'Working Fresher', 'Just started my career'),
    (UserType.professional, '📊', 'Professional', '2+ years experience'),
    (UserType.entrepreneur, '🚀', 'Entrepreneur', 'Running my own venture'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          ShaderMask(
            shaderCallback: (b) =>
                AppColors.primaryGradient.createShader(b),
            child: const Text(
              'Who are you?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This helps us personalize advice for your situation.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
          ),
          const SizedBox(height: 32),
          ..._types.map((t) {
            final isSelected = selected == t.$1;
            return GestureDetector(
              onTap: () => onSelect(t.$1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: isSelected ? AppColors.primaryGradient : null,
                  color: isSelected ? null : AppColors.bgCard,
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : AppColors.bgGlassBorder,
                  ),
                ),
                child: Row(
                  children: [
                    Text(t.$2, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.$3,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.black
                                : AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          t.$4,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.black54
                                : AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (isSelected)
                      const Icon(Icons.check_circle_rounded,
                          color: Colors.black, size: 20),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Step 2: Income ──────────────────────────────────────────────────────────
class _StepIncome extends StatelessWidget {
  final IncomeRange? selected;
  final TextEditingController nameCtrl;
  final ValueChanged<IncomeRange> onSelect;

  const _StepIncome({
    required this.selected,
    required this.nameCtrl,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          ShaderMask(
            shaderCallback: (b) =>
                AppColors.primaryGradient.createShader(b),
            child: const Text(
              'Your finances',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'No exact numbers needed. Just a rough range.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: nameCtrl,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(
              hintText: 'Your first name (optional)',
              prefixIcon: Icon(Icons.person_outline, color: AppColors.textMuted),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Monthly Income',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          ...IncomeRange.values.map((r) {
            final isSelected = selected == r;
            return GestureDetector(
              onTap: () => onSelect(r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: isSelected ? AppColors.primaryGradient : null,
                  color: isSelected ? null : AppColors.bgCard,
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : AppColors.bgGlassBorder,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        r.label,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.black
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_rounded,
                          color: Colors.black, size: 18),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Step 3: Goals ───────────────────────────────────────────────────────────
class _StepGoals extends StatelessWidget {
  final List<String> goals;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const _StepGoals({
    required this.goals,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          ShaderMask(
            shaderCallback: (b) =>
                AppColors.primaryGradient.createShader(b),
            child: const Text(
              'Your goals',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pick at least one — we\'ll prioritize your advice around these.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: goals.map((g) {
              final isSelected = selected.contains(g);
              return GestureDetector(
                onTap: () => onToggle(g),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient:
                        isSelected ? AppColors.primaryGradient : null,
                    color: isSelected ? null : AppColors.bgCard,
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : AppColors.bgGlassBorder,
                    ),
                  ),
                  child: Text(
                    g,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.black
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ─── Gradient CTA Button ─────────────────────────────────────────────────────
class _GradientButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;

  const _GradientButton({required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: onTap != null
              ? AppColors.primaryGradient
              : const LinearGradient(
                  colors: [Color(0xFF1E293B), Color(0xFF1E293B)]),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: onTap != null ? Colors.black : AppColors.textMuted,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
