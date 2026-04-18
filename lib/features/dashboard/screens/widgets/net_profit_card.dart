import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../providers.dart';
import '../../../../shared/widgets/gradient_badge.dart';

class NetProfitCard extends StatelessWidget {
  const NetProfitCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final txnProvider = context.watch<TransactionProvider>();
    final l10n = AppLocalizations.of(context);

    final income = user.monthlyIncome + txnProvider.thisMonthIncome;
    final expenses = txnProvider.thisMonthExpenses;
    final profit = income - expenses;
    final isPositive = profit >= 0;
    final burnPercent = income > 0 ? (expenses / income).clamp(0.0, 1.0) : 0.0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: Theme.of(context).brightness == Brightness.dark
              ? (isPositive
                  ? [const Color(0xFF0A2E23), const Color(0xFF0C1F14)]
                  : [const Color(0xFF2E0A0A), const Color(0xFF1F0C0C)])
              : (isPositive
                  ? [
                      AppColors.primaryGreen.withValues(alpha: 0.15),
                      Colors.white
                    ]
                  : [AppColors.danger.withValues(alpha: 0.15), Colors.white]),
        ),
        border: Border.all(
          color: isPositive
              ? AppColors.primaryGreen.withValues(alpha: 0.3)
              : AppColors.danger.withValues(alpha: 0.3),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('📊', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                l10n.dailyNetProfit,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TonalBadge(
                label: isPositive ? l10n.onTrack : l10n.overBudget,
                color: isPositive ? AppColors.primaryGreen : AppColors.danger,
                icon: isPositive
                    ? Icons.trending_up_rounded
                    : Icons.trending_down_rounded,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                CurrencyFormatter.compact(profit.abs()),
                style: TextStyle(
                  color: isPositive ? AppColors.primaryGreen : AppColors.danger,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6, left: 6),
                child: Text(
                  isPositive ? l10n.surplus : l10n.deficit,
                  style: TextStyle(
                    color: isPositive
                        ? AppColors.primaryGreen.withValues(alpha: 0.7)
                        : AppColors.danger.withValues(alpha: 0.7),
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            l10n.incomeSpent(
              CurrencyFormatter.compact(income),
              CurrencyFormatter.compact(expenses),
            ),
            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
          const SizedBox(height: 16),
          // Burn rate bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.monthlyBurnRate,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '${(burnPercent * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: _burnColor(burnPercent),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: burnPercent,
                  minHeight: 5,
                  backgroundColor: AppColors.bgCardAlt,
                  valueColor: AlwaysStoppedAnimation(_burnColor(burnPercent)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _burnColor(double pct) {
    if (pct < 0.5) return AppColors.primaryGreen;
    if (pct < 0.8) return AppColors.premiumGold;
    return AppColors.danger;
  }
}
