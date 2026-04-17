import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../providers.dart';
import '../../../../core/models/behavior_prediction.dart';
import '../../../../core/models/transaction_model.dart';
import '../../../../shared/widgets/glass_card.dart';

class BehaviorInsightCard extends StatelessWidget {
  const BehaviorInsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, _) {
        final txns = provider.transactions;
        if (txns.isEmpty) return const SizedBox.shrink();

        // Get the latest transaction that has an ML prediction
        TransactionModel? latestWithInsight;
        for (final t in txns) {
          if (t.behaviorPrediction != null) {
            latestWithInsight = t;
            break;
          }
        }

        if (latestWithInsight == null) return const SizedBox.shrink();

        final prediction = latestWithInsight.behaviorPrediction!;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        Color labelColor;
        IconData labelIcon;
        String titleText;

        switch (prediction.label) {
          case BehaviorLabel.good:
            labelColor = AppColors.success;
            labelIcon = Icons.auto_awesome_rounded;
            titleText = 'Good Spending detected';
            break;
          case BehaviorLabel.neutral:
            labelColor = AppColors.warning;
            labelIcon = Icons.balance_rounded;
            titleText = 'Average Spending detected';
            break;
          case BehaviorLabel.poor:
            labelColor = AppColors.danger;
            labelIcon = Icons.warning_rounded;
            titleText = 'Poor Spending detected';
            break;
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   const Text(
                    '🧠',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'AI Behavior Insight',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: labelColor.withOpacity(isDark ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: labelColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(labelIcon, size: 12, color: labelColor),
                        const SizedBox(width: 4),
                        Text(
                          prediction.label.name.toUpperCase(),
                          style: TextStyle(
                            color: labelColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SolidCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: labelColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(labelIcon, color: labelColor, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleText,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            prediction.reason,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Based on: "${latestWithInsight.title}"',
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
