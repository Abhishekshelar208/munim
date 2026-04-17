import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/finance_service.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../providers.dart';

class SmartAlertCard extends StatelessWidget {
  const SmartAlertCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final txnProvider = context.watch<TransactionProvider>();
    final l10n = AppLocalizations.of(context);

    final alerts = FinanceService.instance.generateAlerts(
      monthlyIncome: user.monthlyIncome,
      transactions: txnProvider.transactions.toList(),
      totalSavings: txnProvider.totalSavings,
    );

    if (alerts.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 4),
          child: Row(
            children: [
              const Text('🧠', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Text(
                l10n.smartAlerts,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        ...alerts.map((a) => _AlertTile(alert: a)),
      ],
    );
  }
}

class _AlertTile extends StatelessWidget {
  final SmartAlert alert;

  const _AlertTile({required this.alert});

  @override
  Widget build(BuildContext context) {
    final color = _color(alert.type);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(alert.emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  alert.message,
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

  Color _color(AlertType type) {
    switch (type) {
      case AlertType.danger:  return AppColors.danger;
      case AlertType.warning: return AppColors.premiumGold;
      case AlertType.tip:     return AppColors.primaryGreen;
      case AlertType.info:    return AppColors.accentBlue;
    }
  }
}
