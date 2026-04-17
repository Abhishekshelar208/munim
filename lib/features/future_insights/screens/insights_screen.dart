import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/finance_service.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../providers.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/section_header.dart';

class FutureInsightsScreen extends StatefulWidget {
  const FutureInsightsScreen({super.key});

  @override
  State<FutureInsightsScreen> createState() => _FutureInsightsScreenState();
}

class _FutureInsightsScreenState extends State<FutureInsightsScreen> {
  int _years = 10;
  final List<int> _yearOptions = [5, 10, 20];

  // Insight scenarios: (emoji, label, amount, description)
  List<_InsightScenario> _buildScenarios(double monthlyIncome) {
    final sipAmount = monthlyIncome * 0.10;
    return [
      _InsightScenario(
        emoji: '☕',
        label: 'Daily Coffee',
        monthlyAmount: 1500,
        description: 'Skipping ₹50/day coffee and investing instead',
      ),
      _InsightScenario(
        emoji: '📱',
        label: 'OTT Subscriptions',
        monthlyAmount: 800,
        description: 'Cancelling extra streaming services you barely use',
      ),
      _InsightScenario(
        emoji: '🛍️',
        label: 'Impulse Shopping',
        monthlyAmount: 3000,
        description: 'One unplanned purchase you regret every month',
      ),
      _InsightScenario(
        emoji: '🍕',
        label: 'Dining Out',
        monthlyAmount: 2500,
        description: 'Eating out twice a week vs cooking at home',
      ),
      _InsightScenario(
        emoji: '📈',
        label: 'SIP Investment',
        monthlyAmount: sipAmount,
        description:
            '10% of income (₹${CurrencyFormatter.compact(sipAmount)}) as monthly SIP',
        isPositive: true,
      ),
      _InsightScenario(
        emoji: '💰',
        label: 'Emergency Fund',
        monthlyAmount: monthlyIncome * 0.05,
        description: '5% saved monthly in liquid fund',
        isPositive: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final scenarios = _buildScenarios(user.monthlyIncome);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: _Header(years: _years, yearOptions: _yearOptions, onChanged: (y) => setState(() => _years = y)),
          ),

          // Hero: Your ₹X today = ₹Y later
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                duration: const Duration(milliseconds: 400),
                child: _CompoundHero(
                  income: user.monthlyIncome,
                  years: _years,
                ),
              ),
            ),
          ),

          // Scenarios
          const SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Spending vs Opportunity Cost',
              subtitle: 'What you lose by not investing this money',
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => FadeInLeft(
                  delay: Duration(milliseconds: 50 * i),
                  duration: const Duration(milliseconds: 350),
                  child: _ScenarioCard(scenario: scenarios[i], years: _years),
                ),
                childCount: scenarios.length,
              ),
            ),
          ),

          // Inflation impact
          SliverToBoxAdapter(
            child: FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: _InflationCard(years: _years, income: user.monthlyIncome),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

// ─── Header with year selector ────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final int years;
  final List<int> yearOptions;
  final ValueChanged<int> onChanged;

  const _Header({required this.years, required this.yearOptions, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🔮 Future Insights',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'See the real cost of your decisions',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Projection',
                style: TextStyle(color: AppColors.textMuted, fontSize: 13),
              ),
              const SizedBox(width: 12),
              ...yearOptions.map((y) {
                final sel = y == years;
                return GestureDetector(
                  onTap: () => onChanged(y),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 7),
                    decoration: BoxDecoration(
                      gradient: sel ? AppColors.primaryGradient : null,
                      color: sel ? null : AppColors.bgCard,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: sel
                            ? Colors.transparent
                            : AppColors.bgGlassBorder,
                      ),
                    ),
                    child: Text(
                      '${y}Y',
                      style: TextStyle(
                        color: sel ? Colors.black : AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Compound hero card ───────────────────────────────────────────────────────
class _CompoundHero extends StatelessWidget {
  final double income;
  final int years;

  const _CompoundHero({required this.income, required this.years});

  @override
  Widget build(BuildContext context) {
    final sip = income * 0.20;
    final fv = FinanceService.instance.futureValue(sip * 12, years: years);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF0D2B1F), Color(0xFF091526)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.primaryGreen.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💡 If you invested 20% of income today...',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Today', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                  Text(
                    CurrencyFormatter.compact(sip),
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text('per month', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Icon(Icons.arrow_forward_rounded,
                    color: AppColors.primaryGreen, size: 24),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'In $years years',
                    style: const TextStyle(color: AppColors.primaryGreen, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    CurrencyFormatter.compact(fv),
                    style: const TextStyle(
                      color: AppColors.primaryGreen,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text('at 12% p.a.', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '📌 Index funds (Nifty 50 SIP) have historically returned 12-14% p.a. over 10+ year periods.',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Scenario card ────────────────────────────────────────────────────────────
class _InsightScenario {
  final String emoji;
  final String label;
  final double monthlyAmount;
  final String description;
  final bool isPositive;

  const _InsightScenario({
    required this.emoji,
    required this.label,
    required this.monthlyAmount,
    required this.description,
    this.isPositive = false,
  });
}

class _ScenarioCard extends StatelessWidget {
  final _InsightScenario scenario;
  final int years;

  const _ScenarioCard({required this.scenario, required this.years});

  @override
  Widget build(BuildContext context) {
    final fv = FinanceService.instance.futureValue(
      scenario.monthlyAmount * 12,
      years: years,
    );
    final color = scenario.isPositive ? AppColors.primaryGreen : AppColors.danger;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.bgGlassBorder),
      ),
      child: Row(
        children: [
          Text(scenario.emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scenario.label,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  scenario.description,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '${CurrencyFormatter.compact(scenario.monthlyAmount)}/mo',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      ' → ',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                    ),
                    Text(
                      '${CurrencyFormatter.compact(fv)} in ${years}Y',
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              scenario.isPositive ? '📈' : '📉',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Inflation card ───────────────────────────────────────────────────────────
class _InflationCard extends StatelessWidget {
  final int years;
  final double income;

  const _InflationCard({required this.years, required this.income});

  @override
  Widget build(BuildContext context) {
    final inflationAdjusted =
        FinanceService.instance.inflationAdjusted(income, years: years);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.premiumGold.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.premiumGold.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Inflation Reality Check',
                  style: TextStyle(
                    color: AppColors.premiumGold,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your current income of ${CurrencyFormatter.compact(income)} will only buy goods worth ${CurrencyFormatter.compact(inflationAdjusted)} in $years years (at 6% inflation).',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '→ You need to grow wealth faster than inflation to stay ahead.',
                  style: TextStyle(
                    color: AppColors.premiumGold.withOpacity(0.8),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
