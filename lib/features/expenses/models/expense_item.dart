enum TransactionType { income, expense }

class ExpenseItem {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final String category;
  final DateTime date;
  final String note;

  const ExpenseItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.note = '',
  });

  bool get isExpense => type == TransactionType.expense;
}
