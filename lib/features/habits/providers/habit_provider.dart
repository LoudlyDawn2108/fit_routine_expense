import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../gamification/providers/gamification_provider.dart';
import '../models/habit.dart';

class HabitProvider extends ChangeNotifier {
  final List<Habit> _habits = [
    const Habit(
      id: 'h1',
      title: 'Uống 2L nước mỗi ngày',
      description: 'Duy trì đủ nước cho cơ thể tỉnh táo',
      icon: Icons.water_drop_rounded,
      color: Color(0xFF0984E3),
      xpReward: 15,
      isCompletedToday: true,
      streak: 5,
    ),
    const Habit(
      id: 'h2',
      title: 'Tập thể dục 30 phút',
      description: 'Chạy bộ, gym hoặc yoga tại nhà',
      icon: Icons.fitness_center_rounded,
      color: Color(0xFFE17055),
      xpReward: 30,
      isCompletedToday: false,
      streak: 3,
    ),
    const Habit(
      id: 'h3',
      title: 'Đọc sách 20 phút',
      description: 'Đọc sách chuyên ngành hoặc phát triển bản thân',
      icon: Icons.menu_book_rounded,
      color: Color(0xFF6C5CE7),
      xpReward: 20,
      isCompletedToday: false,
      streak: 2,
    ),
    const Habit(
      id: 'h4',
      title: 'Không chi tiêu lãng phí',
      description: 'Chỉ mua những món đồ thực sự cần thiết',
      icon: Icons.savings_rounded,
      color: Color(0xFF00B894),
      xpReward: 25,
      isCompletedToday: true,
      streak: 4,
    ),
  ];

  List<Habit> get habits => List.unmodifiable(_habits);

  int get completedTodayCount =>
      _habits.where((h) => h.isCompletedToday).length;

  void toggleHabit(String id, GamificationProvider gameProv) {
    final index = _habits.indexWhere((h) => h.id == id);
    if (index != -1) {
      final habit = _habits[index];
      final newStatus = !habit.isCompletedToday;
      final newStreak = newStatus ? habit.streak + 1 : (habit.streak > 0 ? habit.streak - 1 : 0);

      _habits[index] = habit.copyWith(
        isCompletedToday: newStatus,
        streak: newStreak,
      );

      if (newStatus) {
        gameProv.addXp(habit.xpReward, rewardCoins: 15);
      } else {
        gameProv.deductXp(habit.xpReward);
      }

      notifyListeners();
    }
  }

  void addHabit({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required int xpReward,
  }) {
    final newHabit = Habit(
      id: const Uuid().v4(),
      title: title,
      description: description,
      icon: icon,
      color: color,
      xpReward: xpReward,
      isCompletedToday: false,
      streak: 0,
    );
    _habits.add(newHabit);
    notifyListeners();
  }

  void deleteHabit(String id) {
    _habits.removeWhere((h) => h.id == id);
    notifyListeners();
  }
}
