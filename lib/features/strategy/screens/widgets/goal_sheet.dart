import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/models/goal_model.dart';
import '../../../../providers.dart';

class GoalSheet extends StatefulWidget {
  final GoalModel? goal; // null = Create, non-null = Edit

  const GoalSheet({super.key, this.goal});

  @override
  State<GoalSheet> createState() => _GoalSheetState();
}

class _GoalSheetState extends State<GoalSheet> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _addCurrentCtrl = TextEditingController();
  
  String _emoji = '🎯';
  DateTime _deadline = DateTime.now().add(const Duration(days: 90));
  GoalPriority _priority = GoalPriority.medium;
  
  final List<String> _emojiPresets = ['🛡️', '📈', '💻', '🚗', '🏠', '✈️', '🎯', '🎓'];

  @override
  void initState() {
    super.initState();
    if (widget.goal != null) {
      _titleCtrl.text = widget.goal!.title;
      _amountCtrl.text = widget.goal!.targetAmount.toStringAsFixed(0);
      _emoji = widget.goal!.emoji;
      _deadline = widget.goal!.deadline;
      _priority = widget.goal!.priority;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    _addCurrentCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) return;
    
    final target = double.tryParse(_amountCtrl.text) ?? 0;
    if (target <= 0) return;

    final additionalCurrent = double.tryParse(_addCurrentCtrl.text) ?? 0;
    
    final currentTotal = (widget.goal?.currentAmount ?? 0) + additionalCurrent;

    final newGoal = GoalModel(
      id: widget.goal?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      emoji: _emoji,
      targetAmount: target,
      currentAmount: currentTotal.clamp(0, target),
      deadline: _deadline,
      description: widget.goal?.description,
      priority: _priority,
    );

    if (widget.goal == null) {
      context.read<GoalProvider>().addGoal(newGoal);
    } else {
      context.read<GoalProvider>().editGoal(newGoal);
    }
    
    Navigator.of(context).pop();
  }

  void _delete() {
    if (widget.goal != null) {
      context.read<GoalProvider>().deleteGoal(widget.goal!.id);
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (date != null) {
      setState(() => _deadline = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.goal != null;
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? AppColors.bgCard,
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
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEdit ? 'Edit Goal' : 'Create Goal',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (isEdit)
                IconButton(
                  onPressed: _delete,
                  icon: const Icon(Icons.delete_outline_rounded, color: AppColors.danger),
                ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Emojis
          Wrap(
            spacing: 8,
            children: _emojiPresets.map((e) {
              final sel = _emoji == e;
              return GestureDetector(
                onTap: () => setState(() => _emoji = e),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: sel ? AppColors.greenDim : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: sel ? AppColors.primaryGreen : AppColors.bgGlassBorder,
                    ),
                  ),
                  child: Text(e, style: const TextStyle(fontSize: 20)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          
          // Title
          TextField(
            controller: _titleCtrl,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Goal Name (e.g. New Laptop)',
              prefixIcon: const Icon(Icons.label_outline, color: AppColors.textMuted, size: 18),
            ),
          ),
          const SizedBox(height: 12),
          
          // Target Amount
          TextField(
            controller: _amountCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              hintText: 'Target ₹0',
              prefixText: '₹ ',
              prefixStyle: TextStyle(
                color: AppColors.primaryGreen,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Add Progress
          if (isEdit)
             TextField(
              controller: _addCurrentCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                hintText: 'Add to current progress (₹)',
                prefixIcon: Icon(Icons.add_circle_outline_rounded, color: AppColors.primaryGreen, size: 18),
              ),
            ),
          if (isEdit) const SizedBox(height: 12),

          // Deadline
          GestureDetector(
            onTap: _pickDate,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: theme.inputDecorationTheme.fillColor ?? AppColors.bgCardAlt,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, color: AppColors.textMuted, size: 18),
                  const SizedBox(width: 12),
                  Text(
                    'Deadline: ${_deadline.day}/${_deadline.month}/${_deadline.year}',
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Priority Selector
          Row(
            children: [
              const Text('Priority:', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
              const SizedBox(width: 16),
              _buildPriorityChip(GoalPriority.low, 'Low', AppColors.success),
              const SizedBox(width: 8),
              _buildPriorityChip(GoalPriority.medium, 'Med', AppColors.warning),
              const SizedBox(width: 8),
              _buildPriorityChip(GoalPriority.high, 'High', AppColors.danger),
            ],
          ),
          const SizedBox(height: 24),
          
          // Submit
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _save,
              child: Text(isEdit ? 'Save Changes' : 'Create Goal'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityChip(GoalPriority p, String label, Color color) {
    final sel = _priority == p;
    return GestureDetector(
      onTap: () => setState(() => _priority = p),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: sel ? color.withValues(alpha: 0.15) : Colors.transparent,
          border: Border.all(color: sel ? color : AppColors.bgGlassBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: sel ? color : AppColors.textMuted,
            fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
