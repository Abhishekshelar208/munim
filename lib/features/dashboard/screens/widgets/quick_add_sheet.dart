import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/models/transaction_model.dart';
import '../../../../providers.dart';
import '../../../../core/localization/app_localizations.dart';

class QuickAddSheet extends StatefulWidget {
  const QuickAddSheet({super.key});

  @override
  State<QuickAddSheet> createState() => _QuickAddSheetState();
}

class _QuickAddSheetState extends State<QuickAddSheet> {
  final _amountCtrl = TextEditingController();
  final _titleCtrl  = TextEditingController();
  final _noteCtrl   = TextEditingController();

  TransactionType _type = TransactionType.expense;
  TransactionCategory _category = TransactionCategory.food;
  bool _loading = false;

  // Type options built dynamically in build() to use l10n
  List<(TransactionType, String, String)> _typeOptions(AppLocalizations l10n) => [
    (TransactionType.income,     '📥', l10n.income),
    (TransactionType.expense,    '📤', l10n.expense),
    (TransactionType.investment, '📈', l10n.invest),
    (TransactionType.saving,     '🏦', l10n.save),
  ];

  // Category map per type
  static const Map<TransactionType, List<TransactionCategory>> _categoryMap = {
    TransactionType.income: [
      TransactionCategory.salary,
      TransactionCategory.freelance,
      TransactionCategory.business,
      TransactionCategory.gift,
      TransactionCategory.other,
    ],
    TransactionType.expense: [
      TransactionCategory.food,
      TransactionCategory.rent,
      TransactionCategory.transport,
      TransactionCategory.entertainment,
      TransactionCategory.shopping,
      TransactionCategory.dining,
      TransactionCategory.subscription,
      TransactionCategory.utilities,
      TransactionCategory.healthcare,
      TransactionCategory.education,
    ],
    TransactionType.investment: [
      TransactionCategory.stocks,
      TransactionCategory.mutualFunds,
      TransactionCategory.crypto,
      TransactionCategory.gold,
    ],
    TransactionType.saving: [
      TransactionCategory.emergencyFund,
      TransactionCategory.fixedDeposit,
      TransactionCategory.rd,
    ],
  };

  @override
  void dispose() {
    _amountCtrl.dispose();
    _titleCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final amount = double.tryParse(_amountCtrl.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).enterValidAmount)),
      );
      return;
    }
    final title = _titleCtrl.text.trim().isEmpty
        ? _category.displayName
        : _titleCtrl.text.trim();

    final monthlyIncome = context.read<UserProvider>().user.monthlyIncome;

    setState(() => _loading = true);
    await context.read<TransactionProvider>().addTransaction(
      title: title,
      amount: amount,
      type: _type,
      category: _category,
      monthlyIncome: monthlyIncome,
      note: _noteCtrl.text.trim(),
    );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typeOpts = _typeOptions(l10n);
    final cats = _categoryMap[_type] ?? [];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? AppColors.bgCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        left: 20,
        right: 20,
        top: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.bgGlassBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.addTransaction,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),

          // Type selector
          Row(
            children: typeOpts.map((opt) {
              final selected = _type == opt.$1;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    _type = opt.$1;
                    _category = (_categoryMap[opt.$1] ?? []).first;
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(
                      right: opt != typeOpts.last ? 8 : 0,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      gradient: selected ? AppColors.primaryGradient : null,
                      color: selected ? null : Theme.of(context).cardTheme.color ?? Theme.of(context).inputDecorationTheme.fillColor ?? AppColors.bgCardAlt,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(opt.$2, style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 4),
                        Text(
                          opt.$3,
                          style: TextStyle(
                            color: selected ? Colors.black : AppColors.textMuted,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Amount field
          TextField(
            controller: _amountCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              hintText: '₹0',
              prefixText: '₹ ',
              prefixStyle: TextStyle(
                color: AppColors.primaryGreen,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 24),
            ),
          ),
          const SizedBox(height: 12),

          // Title (optional)
          TextField(
            controller: _titleCtrl,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Label (optional, e.g. Groceries)',
              prefixIcon: const Icon(Icons.label_outline, color: AppColors.textMuted, size: 18),
            ),
          ),
          const SizedBox(height: 12),

          // Category chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cats.map((cat) {
              final sel = _category == cat;
              return GestureDetector(
                onTap: () => setState(() => _category = cat),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: sel ? AppColors.greenGradient : null,
                    color: sel ? null : Theme.of(context).cardTheme.color ?? Theme.of(context).inputDecorationTheme.fillColor ?? AppColors.bgCardAlt,
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.bgGlassBorder
                          : AppColors.bgGlassBorderLight,
                    ),
                  ),
                  child: Text(
                    cat.displayName,
                    style: TextStyle(
                      color: sel ? Colors.white : AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Submit
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                  : const Text('Add Transaction'),
            ),
          ),
        ],
      ),
    );
  }
}
