class GamificationState {
  final int level;
  final int currentXp;
  final int maxXp;
  final int streakDays;
  final int coins;
  final String title;
  final String petMood;

  const GamificationState({
    required this.level,
    required this.currentXp,
    required this.maxXp,
    required this.streakDays,
    required this.coins,
    required this.title,
    required this.petMood,
  });

  factory GamificationState.initial() {
    return const GamificationState(
      level: 1,
      currentXp: 45,
      maxXp: 100,
      streakDays: 3,
      coins: 150,
      title: 'Tân Binh Kỷ Luật',
      petMood: 'Vui vẻ 😺',
    );
  }

  GamificationState copyWith({
    int? level,
    int? currentXp,
    int? maxXp,
    int? streakDays,
    int? coins,
    String? title,
    String? petMood,
  }) {
    return GamificationState(
      level: level ?? this.level,
      currentXp: currentXp ?? this.currentXp,
      maxXp: maxXp ?? this.maxXp,
      streakDays: streakDays ?? this.streakDays,
      coins: coins ?? this.coins,
      title: title ?? this.title,
      petMood: petMood ?? this.petMood,
    );
  }

  static String getTitleForLevel(int level) {
    if (level < 3) return 'Tân Binh Kỷ Luật';
    if (level < 5) return 'Chiến Binh Kiên Trì';
    if (level < 10) return 'Bậc Thầy Quản Lý';
    return 'Huyền Thoại Tự Chủ';
  }
}
