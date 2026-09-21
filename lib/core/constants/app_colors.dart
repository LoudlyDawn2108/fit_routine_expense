import 'package:material_ui/material_ui.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF6C5CE7); // Purple Modern
  static const Color primaryLight = Color(0xFFA29BFE);
  static const Color primaryDark = Color(0xFF4834D4);

  static const Color secondary = Color(0xFF00CEC9); // Cyan Mint
  static const Color accent = Color(0xFFFF7675); // Coral Pink

  // Gamification Colors
  static const Color xpGold = Color(0xFFFDCB6E);
  static const Color streakOrange = Color(0xFFFF7675);
  static const Color levelPurple = Color(0xFF6C5CE7);

  // Status & Transaction Colors
  static const Color income = Color(0xFF00B894); // Green
  static const Color expense = Color(0xFFD63031); // Red
  static const Color warning = Color(0xFFE17055);
  static const Color info = Color(0xFF0984E3);

  // Backgrounds & Surfaces (Dark-friendly & Clean Modern)
  static const Color background = Color(0xFF0F172A); // Dark Slate 900
  static const Color surface = Color(0xFF1E293B); // Slate 800
  static const Color surfaceLight = Color(0xFF334155); // Slate 700
  static const Color card = Color(0xFF1E293B);

  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient xpGradient = LinearGradient(
    colors: [Color(0xFFFDCB6E), Color(0xFFE17055)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient petCardGradient = LinearGradient(
    colors: [Color(0xFF1E1B4B), Color(0xFF312E81)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
