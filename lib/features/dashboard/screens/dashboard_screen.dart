import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../expenses/providers/expense_provider.dart';
import '../../gamification/providers/gamification_provider.dart';
import '../../gamification/widgets/pet_avatar_card.dart';
import '../../habits/providers/habit_provider.dart';

class DashboardScreen extends StatelessWidget {
  final Function(int) onTabSelected;

  const DashboardScreen({super.key, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('FitRoutine & Expense'),
            SizedBox(width: 6),
            Text('✨', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Gamification Virtual Pet / Character Card
          const PetAvatarCard(),
          const SizedBox(height: 20),

          // Quick Summary Cards Row
          Consumer2<HabitProvider, ExpenseProvider>(
            builder: (context, habitProv, expProv, child) {
              return Row(
                children: [
                  Expanded(
                    child: _buildQuickStatCard(
                      title: 'Thói Quen Hôm Nay',
                      value:
                          '${habitProv.completedTodayCount}/${habitProv.habits.length}',
                      subtitle: 'Đã hoàn thành',
                      icon: Icons.checklist_rounded,
                      color: AppColors.secondary,
                      onTap: () => onTabSelected(1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickStatCard(
                      title: 'Số Dư Khả Dụng',
                      value: CurrencyFormatter.format(expProv.balance),
                      subtitle: 'Quản lý tài chính',
                      icon: Icons.wallet_rounded,
                      color: AppColors.income,
                      onTap: () => onTabSelected(2),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          // Today's Quick Habits
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Thói Quen Cần Làm',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () => onTabSelected(1),
                child: const Text('Xem tất cả'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Consumer2<HabitProvider, GamificationProvider>(
            builder: (context, habitProv, gameProv, child) {
              final uncompletedHabits = habitProv.habits
                  .where((h) => !h.isCompletedToday)
                  .take(3)
                  .toList();

              if (uncompletedHabits.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.surfaceLight),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.stars_rounded, color: AppColors.xpGold, size: 28),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Tuyệt vời! Bạn đã hoàn thành toàn bộ thói quen hôm nay!',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: uncompletedHabits.map((habit) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.surfaceLight),
                    ),
                    child: ListTile(
                      dense: true,
                      leading: Icon(habit.icon, color: habit.color),
                      title: Text(
                        habit.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.primary.withValues(alpha: 0.2),
                          foregroundColor: AppColors.primaryLight,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          habitProv.toggleHabit(habit.id, gameProv);
                        },
                        child: Text('+${habit.xpReward} XP'),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 20),

          // Recent Expenses Overview
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Chi Tiêu Gần Đây',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () => onTabSelected(2),
                child: const Text('Xem tất cả'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Consumer<ExpenseProvider>(
            builder: (context, expProv, child) {
              final recentTxs = expProv.transactions.take(3).toList();

              if (recentTxs.isEmpty) {
                return const Text(
                  'Chưa có giao dịch nào gần đây.',
                  style: TextStyle(color: AppColors.textMuted),
                );
              }

              return Column(
                children: recentTxs.map((tx) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.surfaceLight),
                    ),
                    child: ListTile(
                      dense: true,
                      leading: Icon(
                        tx.isExpense
                            ? Icons.arrow_downward_rounded
                            : Icons.arrow_upward_rounded,
                        color: tx.isExpense ? AppColors.expense : AppColors.income,
                        size: 20,
                      ),
                      title: Text(tx.title, style: const TextStyle(fontSize: 14)),
                      subtitle: Text(
                        '${tx.category} • ${CurrencyFormatter.formatDate(tx.date)}',
                        style: const TextStyle(fontSize: 11),
                      ),
                      trailing: Text(
                        '${tx.isExpense ? "-" : "+"}${CurrencyFormatter.format(tx.amount)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tx.isExpense ? AppColors.expense : AppColors.income,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget _buildQuickStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surfaceLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 22),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textMuted,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
