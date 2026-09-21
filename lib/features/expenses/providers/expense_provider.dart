import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../gamification/providers/gamification_provider.dart';
import '../models/expense_item.dart';

class ExpenseProvider extends ChangeNotifier {
  final List<ExpenseItem> _transactions = [
    ExpenseItem(
      id: 'tx1',
      title: 'Cơm trưa sinh viên',
      amount: 35000,
      type: TransactionType.expense,
      category: 'Ăn uống',
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ExpenseItem(
      id: 'tx2',
      title: 'Tiền trợ cấp tháng',
      amount: 3000000,
      type: TransactionType.income,
      category: 'Gia đình',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ExpenseItem(
      id: 'tx3',
      title: 'Mua giáo trình Mobile',
      amount: 75000,
      type: TransactionType.expense,
      category: 'Học tập',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ExpenseItem(
      id: 'tx4',
      title: 'Cà phê học nhóm Nhóm 11',
      amount: 45000,
      type: TransactionType.expense,
      category: 'Giải trí',
      date: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  List<ExpenseItem> get transactions => List.unmodifiable(_transactions);

  double get totalIncome => _transactions
      .where((tx) => tx.type == TransactionType.income)
      .fold(0.0, (sum, item) => sum + item.amount);

  double get totalExpense => _transactions
      .where((tx) => tx.type == TransactionType.expense)
      .fold(0.0, (sum, item) => sum + item.amount);

  double get balance => totalIncome - totalExpense;

  void addTransaction({
    required String title,
    required double amount,
    required TransactionType type,
    required String category,
    required DateTime date,
    String note = '',
    GamificationProvider? gameProv,
  }) {
    final newTx = ExpenseItem(
      id: const Uuid().v4(),
      title: title,
      amount: amount,
      type: type,
      category: category,
      date: date,
      note: note,
    );

    _transactions.insert(0, newTx);

    // Ghi chép chi tiêu giúp tăng 10 EXP cho nhân vật!
    gameProv?.addXp(10, rewardCoins: 5);

    notifyListeners();
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }
}
