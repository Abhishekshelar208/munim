import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/finance_service.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../providers.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/gradient_badge.dart';
import 'widgets/net_profit_card.dart';
import 'widgets/freedom_days_card.dart';
import 'widgets/asset_liability_scale.dart';
import 'widgets/smart_alert_card.dart';
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

          // ── Recent Transactions ────────────────────────────────────────
          SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Recent Transactions',
              trailing: TextButton(
                onPressed: () {},
                child: const Text('See all',
                    style: TextStyle(color: AppColors.primaryGreen)),
              ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSheet(context),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Entry',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
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
    final now = DateTime.now();
    final greeting = now.hour < 12
        ? 'Good Morning'
        : now.hour < 17
            ? 'Good Afternoon'
            : 'Good Evening';

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
                user.name.isEmpty ? 'Welcome back!' : user.name,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Notification bell
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.bgGlassBorder),
            ),
            child: const Icon(Icons.notifications_none_rounded,
                color: AppColors.textSecondary, size: 20),
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
              const TonalBadge(
                label: 'Invested',
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
          const Text(
            'This month',
            style: TextStyle(
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
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.bgGlassBorder),
      ),
      child: Column(
        children: [
          const Text('💸', style: TextStyle(fontSize: 36)),
          const SizedBox(height: 12),
          const Text(
            'No transactions yet',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tap "Add Entry" to record your first income or expense',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
