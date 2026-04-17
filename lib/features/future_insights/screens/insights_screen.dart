import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/finance_service.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../providers.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/gradient_badge.dart';
import '../../../core/services/future_service.dart';

class FutureInsightsScreen extends StatefulWidget {
  const FutureInsightsScreen({super.key});

  @override
  State<FutureInsightsScreen> createState() => _FutureInsightsScreenState();
}

class _FutureInsightsScreenState extends State<FutureInsightsScreen> {
  int _years = 10;
  final List<int> _yearOptions = [5, 10, 20];

  List<FutureScenario> _buildScenarios(List<TransactionModel> txns, double monthlyIncome) {
    return FutureService.instance.extractRealScenarios(txns, monthlyIncome);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final txns = context.watch<TransactionProvider>().transactions.toList();
    final l10n = AppLocalizations.of(context);
    final scenarios = _buildScenarios(txns, user.monthlyIncome);
    final rates = FutureService.instance.predictDynamicRates(txns);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: _Header(
              years: _years,
              yearOptions: _yearOptions,
              onChanged: (y) => setState(() => _years = y),
            ),
          ),

          // Hero compound card
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                duration: const Duration(milliseconds: 400),
                child: _CompoundHero(income: user.monthlyIncome, years: _years, rate: rates.assumedReturnRate),
              ),
            ),
          ),

          // Section header
          SliverToBoxAdapter(
            child: Builder(builder: (ctx) {
              final l = AppLocalizations.of(ctx);
              return SectionHeader(
                title: l.spendingVsOpportunityCost,
                subtitle: l.spendingSubtitle,
                trailing: const GradientBadge(label: '✨ AI Generated'),
              );
            }),
          ),

          // Scenario cards
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => FadeInLeft(
                  delay: Duration(milliseconds: 50 * i),
                  duration: const Duration(milliseconds: 350),
                  child: _ScenarioCard(scenario: scenarios[i], years: _years, rate: rates.assumedReturnRate),
                ),
                childCount: scenarios.length,
              ),
            ),
          ),

          // Inflation card
          SliverToBoxAdapter(
            child: FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: _InflationCard(
                    years: _years, income: user.monthlyIncome, inflation: rates.assumedInflation),
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

  const _Header(
      {required this.years,
      required this.yearOptions,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.futureInsightsTitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.futureInsightsSubtitle,
            style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                l10n.projection,
                style:
                    const TextStyle(color: AppColors.textMuted, fontSize: 13),
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
                      gradient:
                          sel ? AppColors.primaryGradient : null,
                      color: sel
                          ? null
                          : Theme.of(context).cardTheme.color ??
                              AppColors.bgCard,
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
                        color: sel
                            ? Colors.black
                            : AppColors.textSecondary,
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
  final double rate;

  const _CompoundHero({required this.income, required this.years, required this.rate});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sip = income * 0.20;
    final fv = FinanceService.instance.futureValue(sip * 12, years: years, rate: rate);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: Theme.of(context).brightness == Brightness.dark
              ? [const Color(0xFF0D2B1F), const Color(0xFF091526)]
              : [
                  AppColors.primaryGreen.withValues(alpha: 0.1),
                  AppColors.bgCardLight
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
            color: AppColors.primaryGreen.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.invest20Percent,
            style: const TextStyle(
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
                  Text(l10n.today,
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 11)),
                  Text(
                    CurrencyFormatter.compact(sip),
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(l10n.perMonth,
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 10)),
                ],
              ),
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Icon(Icons.arrow_forward_rounded,
                    color: AppColors.primaryGreen, size: 24),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.inYears(years),
                    style: const TextStyle(
                        color: AppColors.primaryGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    CurrencyFormatter.compact(fv),
                    style: const TextStyle(
                      color: AppColors.primaryGreen,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(l10n.atReturn,
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 10)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              l10n.indexFundNote,
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
class _ScenarioCard extends StatelessWidget {
  final FutureScenario scenario;
  final int years;
  final double rate;

  const _ScenarioCard({required this.scenario, required this.years, required this.rate});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final fv = FinanceService.instance.futureValue(
      scenario.monthlyAmount * 12,
      years: years,
      rate: rate,
    );
    final color =
        scenario.isPositive ? AppColors.primaryGreen : AppColors.danger;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            Theme.of(context).cardTheme.color ?? AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.bgGlassBorder),
      ),
      child: Row(
        children: [
          Text(scenario.emoji,
              style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scenario.label,
                  style: TextStyle(
                    color:
                        Theme.of(context).colorScheme.onSurface,
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
                      style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12),
                    ),
                    Text(
                      '${CurrencyFormatter.compact(fv)} ${l10n.inYears(years)}',
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
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
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
  final double inflation;

  const _InflationCard({required this.years, required this.income, required this.inflation});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final inflationAdjusted =
        FinanceService.instance.inflationAdjusted(income, years: years, inflation: inflation);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.premiumGold.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: AppColors.premiumGold.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Text('🔥',
              style: TextStyle(fontSize: 28)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.inflationTitle,
                  style: const TextStyle(
                    color: AppColors.premiumGold,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.inflationBody(
                    CurrencyFormatter.compact(income),
                    CurrencyFormatter.compact(inflationAdjusted),
                    years,
                  ),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.inflationCta,
                  style: TextStyle(
                    color: AppColors.premiumGold.withValues(alpha: 0.8),
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
