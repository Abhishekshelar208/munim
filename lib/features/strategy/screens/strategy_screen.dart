import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/finance_service.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../providers.dart';
import '../../../core/models/goal_model.dart';
import '../../../core/models/transaction_model.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/gradient_badge.dart';

class StrategyScreen extends StatelessWidget {
  const StrategyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final wealthRules = [
      _WealthRule('💰', l10n.rule1Title, l10n.rule1Desc, AppColors.primaryGreen),
      _WealthRule('🛡️', l10n.rule2Title, l10n.rule2Desc, AppColors.premiumGold),
      _WealthRule('📈', l10n.rule3Title, l10n.rule3Desc, AppColors.accentBlue),
      _WealthRule('🚫', l10n.rule4Title, l10n.rule4Desc, AppColors.danger),
      _WealthRule('🔄', l10n.rule5Title, l10n.rule5Desc, AppColors.primaryGreen),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _StrategyHeader()),

          // Allocation Dial
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                duration: const Duration(milliseconds: 400),
                child: const _AllocationCard(),
              ),
            ),
          ),

          // Goals
          SliverToBoxAdapter(
            child: Builder(builder: (ctx) {
              final l = AppLocalizations.of(ctx);
              return SectionHeader(
                title: l.yourGoals,
                subtitle: l.trackMilestones,
              );
            }),
          ),

          Consumer<GoalProvider>(
            builder: (_, goalProvider, __) {
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) {
                      final goal = goalProvider.goals[i];
                      return FadeInLeft(
                        delay: Duration(milliseconds: 60 * i),
                        duration: const Duration(milliseconds: 350),
                        child: _GoalCard(goal: goal),
                      );
                    },
                    childCount: goalProvider.goals.length,
                  ),
                ),
              );
            },
          ),

          // Decision Scorecard
          SliverToBoxAdapter(
            child: Builder(builder: (ctx) {
              final l = AppLocalizations.of(ctx);
              return SectionHeader(
                title: l.decisionScorecard,
                subtitle: l.decisionScorecardSubtitle,
              );
            }),
          ),

          Consumer<TransactionProvider>(
            builder: (_, txnProvider, __) {
              final scored = txnProvider.transactions.take(5).toList();
              if (scored.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _EmptyScoreCard(),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) =>
                        _ScoredDecisionTile(transaction: scored[i]),
                    childCount: scored.length,
                  ),
                ),
              );
            },
          ),

          // Wealth Rules
          SliverToBoxAdapter(
            child: Builder(builder: (ctx) {
              return SectionHeader(
                title: AppLocalizations.of(ctx).wealthBuildingRules,
              );
            }),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                wealthRules
                    .map((r) => _WealthRuleTile(rule: r))
                    .toList(),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

// ─── Header ──────────────────────────────────────────────────────────────────
class _StrategyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 16, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.strategyTitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.strategySubtitle,
            style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ─── 50-30-20 Allocation Card ─────────────────────────────────────────────────
class _AllocationCard extends StatelessWidget {
  const _AllocationCard();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final txnProvider = context.watch<TransactionProvider>();
    final l10n = AppLocalizations.of(context);
    final allocation =
        FinanceService.instance.recommendAllocation(user.monthlyIncome);

    // suppress unused warning — kept for future use
    // ignore: unused_local_variable
    final actualExpenses = txnProvider.thisMonthExpenses;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF111C34), Color(0xFF0A1628)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.bgGlassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🎯', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                l10n.moneyAllocation,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const GradientBadge(label: '50-30-20 Rule'),
            ],
          ),
          const SizedBox(height: 20),
          _AllocationRow(
            label: l10n.needsLabel,
            recommended: allocation.needs,
            color: AppColors.accentBlue,
            hint: l10n.needsHint,
          ),
          const SizedBox(height: 12),
          _AllocationRow(
            label: l10n.investSaveLabel,
            recommended: allocation.investSave,
            color: AppColors.primaryGreen,
            hint: l10n.investSaveHint,
          ),
          const SizedBox(height: 12),
          _AllocationRow(
            label: l10n.wantsLabel,
            recommended: allocation.wants,
            color: AppColors.premiumGold,
            hint: l10n.wantsHint,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              l10n.allocationTip(
                  CurrencyFormatter.compact(allocation.investSave)),
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AllocationRow extends StatelessWidget {
  final String label;
  final double recommended;
  final Color color;
  final String hint;

  const _AllocationRow({
    required this.label,
    required this.recommended,
    required this.color,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              CurrencyFormatter.compact(recommended),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: 0.7,
            minHeight: 5,
            backgroundColor:
                Theme.of(context).cardTheme.color ?? AppColors.bgCardAlt,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
        const SizedBox(height: 3),
        Text(hint,
            style: const TextStyle(
                color: AppColors.textMuted, fontSize: 10)),
      ],
    );
  }
}

// ─── Goal Card ────────────────────────────────────────────────────────────────
class _GoalCard extends StatelessWidget {
  final GoalModel goal;
  const _GoalCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.bgGlassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(goal.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      l10n.daysLeft(goal.daysLeft),
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Text(
                CurrencyFormatter.compact(goal.remaining),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: goal.progressPercent,
              minHeight: 6,
              backgroundColor:
                  Theme.of(context).cardTheme.color ?? AppColors.bgCardAlt,
              valueColor:
                  const AlwaysStoppedAnimation(AppColors.primaryGreen),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.percentComplete(
                    (goal.progressPercent * 100).toStringAsFixed(0)),
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${CurrencyFormatter.compact(goal.currentAmount)} / ${CurrencyFormatter.compact(goal.targetAmount)}',
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Scored decision tile ──────────────────────────────────────────────────────
class _ScoredDecisionTile extends StatelessWidget {
  final TransactionModel transaction;
  const _ScoredDecisionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (label, color, icon) = switch (transaction.roiLabel) {
      RoiLabel.excellent => (l10n.scoreExcellent, AppColors.primaryGreen,   '🏆'),
      RoiLabel.good      => (l10n.scoreGood,      AppColors.accentBlueLight, '✅'),
      RoiLabel.neutral   => (l10n.scoreNeutral,   AppColors.textMuted,       '➡️'),
      RoiLabel.poor      => (l10n.scoreReview,    AppColors.premiumGold,     '⚠️'),
      RoiLabel.terrible  => (l10n.scoreBadMove,   AppColors.danger,          '❌'),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.bgGlassBorder),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              transaction.title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Text(
            CurrencyFormatter.format(transaction.amount),
            style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(width: 10),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyScoreCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.bgGlassBorder),
      ),
      child: Center(
        child: Text(
          AppLocalizations.of(context).addTxnForScores,
          style: const TextStyle(
              color: AppColors.textMuted, fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// ─── Wealth Rule tile ─────────────────────────────────────────────────────────
class _WealthRule {
  final String emoji;
  final String title;
  final String description;
  final Color color;
  const _WealthRule(this.emoji, this.title, this.description, this.color);
}

class _WealthRuleTile extends StatelessWidget {
  final _WealthRule rule;
  const _WealthRuleTile({required this.rule});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: rule.color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: rule.color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(rule.emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rule.title,
                  style: TextStyle(
                    color: rule.color,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  rule.description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.4,
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
