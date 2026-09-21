import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../expenses/models/expense_item.dart';
import '../../expenses/providers/expense_provider.dart';
import '../../habits/providers/habit_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo Cáo & Thống Kê'),
      ),
      body: Consumer2<ExpenseProvider, HabitProvider>(
        builder: (context, expProv, habitProv, child) {
          final txs = expProv.transactions
              .where((t) => t.type == TransactionType.expense)
              .toList();

          // Calculate category totals
          final Map<String, double> categoryTotals = {};
          for (var t in txs) {
            categoryTotals[t.category] =
                (categoryTotals[t.category] ?? 0) + t.amount;
          }

          final totalExpense = expProv.totalExpense;

          final colors = [
            const Color(0xFF6C5CE7),
            const Color(0xFFFF7675),
            const Color(0xFF00CEC9),
            const Color(0xFFFDCB6E),
            const Color(0xFF0984E3),
            const Color(0xFFE17055),
            const Color(0xFF00B894),
          ];

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              // Habit Completion Rate
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.surfaceLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tỷ Lệ Kỷ Luật Thói Quen',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${habitProv.completedTodayCount} / ${habitProv.habits.length} hoàn thành',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: habitProv.habits.isEmpty
                                    ? 0
                                    : habitProv.completedTodayCount /
                                        habitProv.habits.length,
                                backgroundColor: AppColors.surfaceLight,
                                valueColor: const AlwaysStoppedAnimation(
                                  AppColors.secondary,
                                ),
                                minHeight: 8,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.emoji_events_rounded,
                            color: AppColors.secondary,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Expense Pie Chart
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.surfaceLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phân Bổ Chi Tiêu Theo Danh Mục',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (categoryTotals.isEmpty || totalExpense == 0)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text(
                            'Chưa có dữ liệu chi tiêu để vẽ biểu đồ.',
                            style: TextStyle(color: AppColors.textMuted),
                          ),
                        ),
                      )
                    else ...[
                      SizedBox(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 3,
                            centerSpaceRadius: 40,
                            sections: categoryTotals.entries.map((entry) {
                              final index = categoryTotals.keys
                                      .toList()
                                      .indexOf(entry.key) %
                                  colors.length;
                              final percentage =
                                  (entry.value / totalExpense) * 100;
                              return PieChartSectionData(
                                color: colors[index],
                                value: entry.value,
                                title: '${percentage.round()}%',
                                radius: 50,
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Legend
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: categoryTotals.entries.map((entry) {
                          final index = categoryTotals.keys
                                  .toList()
                                  .indexOf(entry.key) %
                              colors.length;
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: colors[index],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${entry.key} (${CurrencyFormatter.format(entry.value)})',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
