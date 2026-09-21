import 'package:material_ui/material_ui.dart';

class Habit {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int xpReward;
  final bool isCompletedToday;
  final int streak;

  const Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.xpReward,
    required this.isCompletedToday,
    required this.streak,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    Color? color,
    int? xpReward,
    bool? isCompletedToday,
    int? streak,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      xpReward: xpReward ?? this.xpReward,
      isCompletedToday: isCompletedToday ?? this.isCompletedToday,
      streak: streak ?? this.streak,
    );
  }
}
