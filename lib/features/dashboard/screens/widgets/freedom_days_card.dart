import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/finance_service.dart';
import '../../../../core/models/transaction_model.dart';
import '../../../../providers.dart';
import '../../../../shared/widgets/glass_card.dart';

class FreedomDaysCard extends StatelessWidget {
  const FreedomDaysCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final txnProvider = context.watch<TransactionProvider>();

    final essentialExpenses = txnProvider.thisMonthTransactions
        .where((t) =>
            t.type == TransactionType.expense && t.category.isEssential)
        .fold(0.0, (s, t) => s + t.amount);

    final freedomDays = FinanceService.instance.calculateDaysOfFreedom(
      totalSavings: txnProvider.totalSavings,
      monthlyEssentialExpenses: essentialExpenses == 0
          ? user.monthlyIncome * 0.5
          : essentialExpenses,
    );

    final level = freedomDays < 30
        ? ('🔴', 'Critical')
        : freedomDays < 90
            ? ('🟡', 'Low')
            : freedomDays < 180
                ? ('🟢', 'Safe')
                : ('🏆', 'Strong');

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
                  color: AppColors.premiumGold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('🛡️', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '$freedomDays',
            style: const TextStyle(
              color: AppColors.premiumGold,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const Text(
            'Days of Freedom',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${level.$1} ${level.$2}',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
