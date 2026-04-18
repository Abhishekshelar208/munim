import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/gradient_badge.dart';
import '../../../providers.dart';
import '../../../core/services/growth_service.dart';

class GrowthScreen extends StatelessWidget {
  const GrowthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // final txns = context.watch<TransactionProvider>().transactions.toList();
    // final metrics = GrowthService.instance.calculateGrowth(txns);

    // 🔥 HARDCODED FOR DEMO 🔥
    final metrics = GrowthMetrics(
      currentSavings: 18500.0,
      previousSavings: 12000.0,
      growthPercentage: 54.2,
      trend: GrowthTrend.up,
      insight: 'Incredible momentum! You saved ₹6,500 more than last month. This extreme discipline is crushing your goals much earlier than predicted.',
    );

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
                    'Track your personal financial growth over time.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          // Main Growth Card
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                duration: const Duration(milliseconds: 400),
                child: _GrowthHeroCard(metrics: metrics),
              ),
            ),
          ),

          // Discipline Insights
          SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Discipline Insights',
              trailing: const GradientBadge(label: '✨ AI Generated'),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: FadeInLeft(
                delay: const Duration(milliseconds: 100),
                duration: const Duration(milliseconds: 400),
                child: _InsightCard(metrics: metrics),
              ),
            ),
          ),
          
          if (metrics.currentSavings > metrics.previousSavings && metrics.previousSavings > 0)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              sliver: SliverToBoxAdapter(
                child: FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: _PersonalRecordBadge(),
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

// ─── Growth Hero Card ───────────────────────────────────────────────────────
class _GrowthHeroCard extends StatelessWidget {
  final GrowthMetrics metrics;
  const _GrowthHeroCard({required this.metrics});

  @override
  Widget build(BuildContext context) {
    final isUp = metrics.trend == GrowthTrend.up;
    final isDown = metrics.trend == GrowthTrend.down;
    
    final color = isUp ? AppColors.success : (isDown ? AppColors.danger : AppColors.warning);
    final icon = isUp ? Icons.trending_up_rounded : (isDown ? Icons.trending_down_rounded : Icons.trending_flat_rounded);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 24, top: 8),
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
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
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
              Text(
                '${metrics.growthPercentage > 0 ? '+' : ''}${metrics.growthPercentage.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: color,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
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
              Expanded(
                child: _StatBlock(
                  label: 'This Month',
                  amount: metrics.currentSavings,
                  highlight: true,
                ),
              ),
              Container(width: 1, height: 40, color: AppColors.bgGlassBorder),
              Expanded(
                child: _StatBlock(
                  label: 'Last Month',
                  amount: metrics.previousSavings,
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

// ─── Insight Card ───────────────────────────────────────────────────────────
class _InsightCard extends StatelessWidget {
  final GrowthMetrics metrics;
  const _InsightCard({required this.metrics});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCardAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.bgGlassBorder
              : AppColors.bgGlassBorderLight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('💡', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              metrics.insight,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Personal Record Badge ──────────────────────────────────────────────────
class _PersonalRecordBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.premiumGold.withOpacity(0.15), AppColors.bgCardLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.premiumGold.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_events_rounded, color: AppColors.premiumGold, size: 28),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
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
        ],
      ),
    );
  }
}
