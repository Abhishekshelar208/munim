import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';

class GrowthScreen extends StatelessWidget {
  const GrowthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progress',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'We don\'t just show data—we show consequences.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          // SELF COMPARISON (HARDCODED DEMO)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                duration: const Duration(milliseconds: 400),
                child: const _GrowthHeroCard(),
              ),
            ),
          ),
          
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: const _PersonalRecordBadge(),
              ),
            ),
          ),

          // FEATURE 1: FUTURE YOU REALITY MIRROR
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                duration: const Duration(milliseconds: 400),
                child: const _FutureMirrorCard(),
              ),
            ),
          ),

          // FEATURE 2: FIRST ₹1 LAKH TRACKER
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                delay: const Duration(milliseconds: 100),
                duration: const Duration(milliseconds: 400),
                child: const _LakhTrackerCard(),
              ),
            ),
          ),

          // FEATURE 3: REGRET SIMULATOR
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 400),
                child: const _RegretSimulatorCard(),
              ),
            ),
          ),

          // FEATURE 4: MIDDLE-CLASS TRAP DETECTOR
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 400),
                child: const _TrapDetectorCard(),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

// ─── 1. Future You Reality Mirror ───────────────────────────────────────────
class _FutureMirrorCard extends StatelessWidget {
  const _FutureMirrorCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.bgGlassBorder
              : AppColors.bgGlassBorderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Future Depends on Today\'s Decisions',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // LEFT SIDE - No Growth
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.05),
                    border: Border.all(color: AppColors.danger.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Future if you continue current habits',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        CurrencyFormatter.compact(20000),
                        style: const TextStyle(
                          color: AppColors.danger,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.danger,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('No growth', style: TextStyle(color: Colors.white, fontSize: 9)),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Financial Stress',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.danger),
                      ),
                    ],
                  ),
                ),
              ),
              
              // ARROW
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.arrow_forward_rounded, color: AppColors.textMuted, size: 20),
              ),

              // RIGHT SIDE - Disciplined Growth
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    border: Border.all(color: AppColors.success.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Future if you improve decisions',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${CurrencyFormatter.compact(500000)}+',
                        style: const TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('Disciplined growth', style: TextStyle(color: Colors.white, fontSize: 9)),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Financial Freedom',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.success),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── 2. First ₹1 Lakh Tracker ───────────────────────────────────────────────
class _LakhTrackerCard extends StatefulWidget {
  const _LakhTrackerCard();

  @override
  State<_LakhTrackerCard> createState() => _LakhTrackerCardState();
}

class _LakhTrackerCardState extends State<_LakhTrackerCard> with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _progressAnim = Tween<double>(begin: 0, end: 0.25).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _animCtrl.forward();
    });
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.bgGlassBorder
              : AppColors.bgGlassBorderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'First ₹1 Lakh Journey',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: AppColors.premiumGold.withOpacity(0.2), shape: BoxShape.circle),
                child: const Icon(Icons.emoji_events_rounded, color: AppColors.premiumGold, size: 20),
              )
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'You\'ve completed 25% of your first ₹1 lakh journey',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 24),
          
          AnimatedBuilder(
            animation: _progressAnim,
            builder: (context, _) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        CurrencyFormatter.compact(25000),
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.primaryGreen),
                      ),
                      Text(
                        CurrencyFormatter.compact(100000),
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    children: [
                      Container(
                        height: 12,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.bgGlassBorder,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: _progressAnim.value,
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [AppColors.primaryGreen, AppColors.accentBlue]),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(color: AppColors.primaryGreen.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 2))
                            ]
                          ),
                        ),
                      ),
                      // Milestone markers
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(width: 2, height: 12, color: Colors.black.withOpacity(0.1)),
                            Container(width: 2, height: 12, color: Colors.black.withOpacity(0.1)),
                            Container(width: 2, height: 12, color: Colors.black.withOpacity(0.1)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          ),
        ],
      ),
    );
  }
}

// ─── 3. Regret Simulator ────────────────────────────────────────────────────
class _RegretSimulatorCard extends StatelessWidget {
  const _RegretSimulatorCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.warning.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.warning_amber_rounded, color: AppColors.warning),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Regret Simulator',
                  style: TextStyle(color: AppColors.warning, fontWeight: FontWeight.w800, fontSize: 16),
                ),
                const SizedBox(height: 6),
                const Text(
                  '₹2,000 spent on food',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Based on your pattern, you may regret this in 2–3 days.',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.bgDeep.withOpacity(0.4), borderRadius: BorderRadius.circular(6)),
                  child: const Text(
                    'Past behavior indicates short-term satisfaction, long-term regret.',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 11, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ─── 4. Middle-Class Trap Detector ──────────────────────────────────────────
class _TrapDetectorCard extends StatelessWidget {
  const _TrapDetectorCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.danger.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.danger.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: AppColors.danger.withOpacity(0.05),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.radar_rounded, color: AppColors.danger, size: 24),
              const SizedBox(width: 12),
              const Text(
                'Middle-Class Trap Detector',
                style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'You are entering a financial trap',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          const SizedBox(height: 16),
          _TrapIndicatorRow(label: 'EMI Mindset detected', active: true),
          const SizedBox(height: 8),
          _TrapIndicatorRow(label: 'No active investment growth', active: true),
          const SizedBox(height: 8),
          _TrapIndicatorRow(label: 'Consumption > Savings', active: true),
        ],
      ),
    );
  }
}

class _TrapIndicatorRow extends StatelessWidget {
  final String label;
  final bool active;

  const _TrapIndicatorRow({required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          active ? Icons.dangerous_rounded : Icons.check_circle_rounded,
          color: active ? AppColors.danger : AppColors.success,
          size: 16,
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: active ? AppColors.textPrimary : AppColors.textSecondary,
            fontSize: 13,
            fontWeight: active ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

// ─── Self Comparison Components ─────────────────────────────────────────────
class _GrowthHeroCard extends StatelessWidget {
  const _GrowthHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, top: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.bgGlassBorder
              : AppColors.bgGlassBorderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.trending_up_rounded, color: AppColors.success, size: 24),
              ),
              const SizedBox(width: 16),
              const Text(
                'Your Growth This Month',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '+50.0%',
                style: TextStyle(
                  color: AppColors.success,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: const Text(
                  'vs last month',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(
                child: _StatBlock(
                  label: 'This Month',
                  amount: 18000,
                  highlight: true,
                ),
              ),
              Container(width: 1, height: 40, color: AppColors.bgGlassBorder),
              const Expanded(
                child: _StatBlock(
                  label: 'Last Month',
                  amount: 12000,
                  highlight: false,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String label;
  final double amount;
  final bool highlight;

  const _StatBlock({required this.label, required this.amount, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          CurrencyFormatter.format(amount),
          style: TextStyle(
            color: highlight ? AppColors.textPrimary : AppColors.textSecondary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _PersonalRecordBadge extends StatelessWidget {
  const _PersonalRecordBadge();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.premiumGold.withOpacity(0.15), Colors.transparent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.premiumGold.withOpacity(0.4)),
      ),
      child: Row(
        children: const [
          Icon(Icons.emoji_events_rounded, color: AppColors.premiumGold, size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personal Record!',
                  style: TextStyle(color: AppColors.premiumGold, fontSize: 16, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 2),
                Text(
                  'You broke your own savings record.',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
