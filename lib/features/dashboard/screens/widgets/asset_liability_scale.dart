import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/finance_service.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../providers.dart';
import '../../../../shared/widgets/glass_card.dart';

class AssetLiabilityScale extends StatelessWidget {
  const AssetLiabilityScale({super.key});

  @override
  Widget build(BuildContext context) {
    final txns = context.watch<TransactionProvider>().transactions.toList();
    final assets = FinanceService.instance.calculateTotalAssets(txns);
    final liabilities = FinanceService.instance.calculateTotalLiabilities(txns);
    final total = assets + liabilities;
    final assetFraction = total == 0 ? 0.5 : (assets / total).clamp(0, 1);

    return SolidCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('⚖️', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text(
                'Asset vs Liability',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ScaleLabel(
                label: 'Assets',
                value: assets,
                color: AppColors.primaryGreen,
                isLeft: true,
              ),
              _ScaleLabel(
                label: 'Liabilities',
                value: liabilities,
                color: AppColors.danger,
                isLeft: false,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // The balance bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 12,
              child: Row(
                children: [
                  Expanded(
                    flex: (assetFraction * 100).round(),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: AppColors.greenGradient,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: ((1 - assetFraction) * 100).round(),
                    child: Container(
                      color: AppColors.danger.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              total == 0
                  ? 'Add transactions to see your financial health'
                  : assetFraction > 0.6
                      ? '✅ Your assets are growing. Keep investing!'
                      : assetFraction > 0.4
                          ? '⚠️ Balance your spending with saving'
                          : '🔴 Liabilities dominate. Time to restrategize.',
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScaleLabel extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final bool isLeft;

  const _ScaleLabel({
    required this.label,
    required this.value,
    required this.color,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          CurrencyFormatter.compact(value),
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
