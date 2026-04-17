import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/models/transaction_model.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_helpers.dart';
import '../../../../providers.dart';
import '../../../../shared/widgets/gradient_badge.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final isInvestment = transaction.type == TransactionType.investment;
    final isSaving = transaction.type == TransactionType.saving;
    final isPositive = isIncome || isInvestment || isSaving;

    final color = isPositive ? AppColors.primaryGreen : AppColors.danger;
    final sign = isPositive ? '+' : '-';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.bgGlassBorder, width: 0.5),
      ),
      child: Row(
        children: [
          // Category icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                _categoryEmoji(transaction.category),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      transaction.category.displayName,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                    const Text(' · ', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                    Text(
                      DateHelpers.relativeDate(transaction.date),
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$sign${CurrencyFormatter.format(transaction.amount)}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 3),
              _RoiChip(label: transaction.roiLabel),
            ],
          ),
        ],
      ),
    );
  }

  String _categoryEmoji(TransactionCategory cat) {
    switch (cat) {
      case TransactionCategory.salary:       return '💼';
      case TransactionCategory.freelance:    return '🖥️';
      case TransactionCategory.food:         return '🍽️';
      case TransactionCategory.rent:         return '🏠';
      case TransactionCategory.transport:    return '🚗';
      case TransactionCategory.entertainment:return '🎬';
      case TransactionCategory.shopping:     return '🛍️';
      case TransactionCategory.stocks:       return '📈';
      case TransactionCategory.mutualFunds:  return '💰';
      case TransactionCategory.education:    return '📚';
      case TransactionCategory.healthcare:   return '🏥';
      case TransactionCategory.dining:       return '🍜';
      case TransactionCategory.subscription: return '📱';
      case TransactionCategory.travel:       return '✈️';
      default:                               return '💳';
    }
  }
}

class _RoiChip extends StatelessWidget {
  final RoiLabel label;
  const _RoiChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final (text, color) = switch (label) {
      RoiLabel.excellent => ('Excellent ROI', AppColors.primaryGreen),
      RoiLabel.good      => ('Good', AppColors.accentBlueLight),
      RoiLabel.neutral   => ('Neutral', AppColors.textMuted),
      RoiLabel.poor      => ('Poor ROI', AppColors.premiumGold),
      RoiLabel.terrible  => ('Bad Move', AppColors.danger),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w600),
      ),
    );
  }
}
