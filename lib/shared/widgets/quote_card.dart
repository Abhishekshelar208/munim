import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/quote_service.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final bool animate;

  const QuoteCard({
    super.key,
    required this.quote,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCardAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.bgGlassBorder
              : AppColors.bgGlassBorderLight,
          width: 0.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.format_quote_rounded,
            color: AppColors.primaryGreen,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quote.text,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
                if (quote.author != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    '— ${quote.author}',
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
