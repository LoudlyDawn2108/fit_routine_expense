import 'package:flutter/foundation.dart';
import '../models/gamification_state.dart';

class GamificationProvider extends ChangeNotifier {
  GamificationState _state = GamificationState.initial();

  GamificationState get state => _state;

  void addXp(int xp, {int rewardCoins = 10}) {
    int newXp = _state.currentXp + xp;
    int newLevel = _state.level;
    int newMaxXp = _state.maxXp;
    int newCoins = _state.coins + rewardCoins;

    // Level up calculation
    while (newXp >= newMaxXp) {
      newXp -= newMaxXp;
      newLevel += 1;
      newMaxXp = (newMaxXp * 1.3).round();
    }

    _state = _state.copyWith(
      level: newLevel,
      currentXp: newXp,
      maxXp: newMaxXp,
      coins: newCoins,
      title: GamificationState.getTitleForLevel(newLevel),
      petMood: newLevel > _state.level ? 'Phấn khích! 🚀' : 'Hào hứng ✨',
    );

    notifyListeners();
  }

  void deductXp(int xp) {
    int newXp = _state.currentXp - xp;
    if (newXp < 0) newXp = 0;
    _state = _state.copyWith(currentXp: newXp);
    notifyListeners();
  }

  void incrementStreak() {
    _state = _state.copyWith(streakDays: _state.streakDays + 1);
    notifyListeners();
  }

  void resetStreak() {
    _state = _state.copyWith(streakDays: 0);
    notifyListeners();
  }
}
