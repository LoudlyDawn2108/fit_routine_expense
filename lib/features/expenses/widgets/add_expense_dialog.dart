import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../gamification/providers/gamification_provider.dart';
import '../models/expense_item.dart';
import '../providers/expense_provider.dart';

class AddExpenseDialog extends StatefulWidget {
  const AddExpenseDialog({super.key});

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;
  String _selectedCategory = 'Ăn uống';

  final List<String> _expenseCategories = [
    'Ăn uống',
    'Học tập',
    'Giải trí',
    'Đi lại',
    'Mua sắm',
    'Hóa đơn',
    'Khác'
  ];

  final List<String> _incomeCategories = [
    'Lương',
    'Trợ cấp',
    'Thưởng',
    'Bán đồ cũ',
    'Khác'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = _selectedType == TransactionType.expense
        ? _expenseCategories
        : _incomeCategories;

    if (!categories.contains(_selectedCategory)) {
      _selectedCategory = categories[0];
    }

    return AlertDialog(
      title: const Text(
        'Ghi Chép Thu / Chi',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Switch Type
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('Chi tiêu')),
                    selected: _selectedType == TransactionType.expense,
                    selectedColor: AppColors.expense.withValues(alpha: 0.3),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedType = TransactionType.expense);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('Thu nhập')),
                    selected: _selectedType == TransactionType.income,
                    selectedColor: AppColors.income.withValues(alpha: 0.3),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedType = TransactionType.income);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Mô tả / Tên khoản *',
                hintText: 'VD: Ăn sáng bánh mì',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Số tiền (VNĐ) *',
                hintText: 'VD: 30000',
                suffixText: '₫',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Danh mục',
                border: OutlineInputBorder(),
              ),
              items: categories.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedCategory = val);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Ghi chú thêm',
                hintText: 'VD: Mua cùng bạn',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy', style: TextStyle(color: AppColors.textMuted)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedType == TransactionType.expense
                ? AppColors.expense
                : AppColors.income,
          ),
          onPressed: () {
            final title = _titleController.text.trim();
            final amount = double.tryParse(_amountController.text.trim()) ?? 0;

            if (title.isEmpty || amount <= 0) return;

            final gameProv = context.read<GamificationProvider>();
            context.read<ExpenseProvider>().addTransaction(
                  title: title,
                  amount: amount,
                  type: _selectedType,
                  category: _selectedCategory,
                  date: DateTime.now(),
                  note: _noteController.text.trim(),
                  gameProv: gameProv,
                );

            Navigator.pop(context);
          },
          child: const Text('Lưu giao dịch', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
