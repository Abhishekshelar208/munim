import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/finance_service.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../providers.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/gradient_badge.dart';
import 'widgets/net_profit_card.dart';
import 'widgets/freedom_days_card.dart';
import 'widgets/asset_liability_scale.dart';
import 'widgets/smart_alert_card.dart';
import 'widgets/behavior_insight_card.dart';
import 'widgets/quick_add_sheet.dart';
import 'widgets/transaction_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Custom App Bar ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _DashboardHeader(),
          ),

          // ── KPI Cards ──────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 400),
                    child: const NetProfitCard(),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    duration: const Duration(milliseconds: 400),
                    child: Row(
                      children: const [
                        Expanded(child: FreedomDaysCard()),
                        SizedBox(width: 12),
                        Expanded(child: _MonthlyInvestCard()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Asset / Liability Scale ─────────────────────────────────────
          SliverToBoxAdapter(
            child: FadeInUp(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 400),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: AssetLiabilityScale(),
              ),
            ),
          ),

          // ── Smart Alerts ───────────────────────────────────────────────
          SliverToBoxAdapter(
            child: FadeInUp(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 400),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SmartAlertCard(),
              ),
            ),
          ),

          // ── Behavior Insight ───────────────────────────────────────────
          SliverToBoxAdapter(
            child: FadeInUp(
              delay: const Duration(milliseconds: 350),
              duration: const Duration(milliseconds: 400),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: BehaviorInsightCard(),
              ),
            ),
          ),

          // ── Recent Transactions ────────────────────────────────────────
          SliverToBoxAdapter(
            child: Builder(
              builder: (ctx) {
                final l10n = AppLocalizations.of(ctx);
                return SectionHeader(
                  title: l10n.recentTransactions,
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text(l10n.seeAll,
                        style: const TextStyle(color: AppColors.primaryGreen)),
                  ),
                );
              },
            ),
          ),

          Consumer<TransactionProvider>(
            builder: (_, provider, __) {
              final txns = provider.transactions.take(6).toList();
              if (txns.isEmpty) {
                return SliverToBoxAdapter(child: _EmptyTransactions());
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => FadeInLeft(
                      delay: Duration(milliseconds: 50 * i),
                      duration: const Duration(milliseconds: 350),
                      child: TransactionTile(transaction: txns[i]),
                    ),
                    childCount: txns.length,
                  ),
                ),
              );
            },
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),

      // ── FAB ────────────────────────────────────────────────────────────
      floatingActionButton: Builder(
        builder: (ctx) {
          final l10n = AppLocalizations.of(ctx);
          return FloatingActionButton.extended(
            onPressed: () => _showAddSheet(context),
            backgroundColor: AppColors.primaryGreen,
            foregroundColor: Colors.black,
            icon: const Icon(Icons.add_rounded),
            label: Text(
              l10n.addEntry,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          );
        },
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const QuickAddSheet(),
    );
  }
}

// ─── Dashboard Header ─────────────────────────────────────────────────────────
class _DashboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final greeting = now.hour < 12
        ? l10n.goodMorning
        : now.hour < 17
            ? l10n.goodAfternoon
            : l10n.goodEvening;

    return Container(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 16, 20, 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greeting 👋',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                user.name.isEmpty ? l10n.welcomeBack : user.name,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Theme Toggle
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return GestureDetector(
                onTap: () {
                  if (themeProvider.themeMode == ThemeMode.system) {
                    themeProvider.setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
                  } else {
                    themeProvider.setThemeMode(
                        themeProvider.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).dividerTheme.color ?? Colors.transparent),
                  ),
                  child: Icon(
                    themeProvider.themeMode == ThemeMode.system
                        ? Icons.brightness_auto_rounded
                        : isDark
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                    color: Theme.of(context).iconTheme.color,
                    size: 20,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          // Language Toggle
          Consumer<LanguageProvider>(
            builder: (context, langProvider, _) {
              return GestureDetector(
                onTap: () => _showLanguagePicker(context, langProvider),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Theme.of(context).dividerTheme.color ?? Colors.transparent),
                  ),
                  child: Icon(Icons.language_rounded,
                      color: Theme.of(context).iconTheme.color, size: 20),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          // Notification bell
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).dividerTheme.color ?? Colors.transparent),
            ),
            child: Icon(Icons.notifications_none_rounded,
                color: Theme.of(context).iconTheme.color, size: 20),
          ),
          const SizedBox(width: 8),
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                user.name.isEmpty ? 'M' : user.name[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, LanguageProvider langProvider) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36, height: 4,
                decoration: BoxDecoration(
                  color: AppColors.bgGlassBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.selectLanguage,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18, fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            ...AppLocalizations.supportedLocales.map((locale) {
              final isSelected = langProvider.languageCode == locale.languageCode;
              return GestureDetector(
                onTap: () {
                  langProvider.setLocale(locale);
                  Navigator.pop(context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.primaryGradient : null,
                    color: isSelected ? null : Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                    border: isSelected ? null : Border.all(color: AppColors.bgGlassBorder),
                  ),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.languageNameFor(locale.languageCode),
                        style: TextStyle(
                          color: isSelected ? Colors.black : Theme.of(context).colorScheme.onSurface,
                          fontSize: 15, fontWeight: FontWeight.w600,
                        ),
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
      ),
    );
  }
}

// ─── Monthly Invest Card (small) ─────────────────────────────────────────────
class _MonthlyInvestCard extends StatelessWidget {
  const _MonthlyInvestCard();

  @override
  Widget build(BuildContext context) {
    final txnProvider = context.watch<TransactionProvider>();
    final invested = txnProvider.thisMonthInvestments;

    return SolidCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.accentBlue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.trending_up_rounded,
                    color: AppColors.accentBlue, size: 16),
              ),
              const Spacer(),
              TonalBadge(
                label: AppLocalizations.of(context).invested,
                color: AppColors.accentBlue,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            CurrencyFormatter.compact(invested),
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            AppLocalizations.of(context).thisMonth,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────
class _EmptyTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.bgGlassBorder),
      ),
      child: Column(
        children: [
          const Text('💸', style: TextStyle(fontSize: 36)),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context).noTransactionsYet,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context).noTransactionsHint,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
