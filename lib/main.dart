import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/screens/main_navigation_screen.dart';
import 'features/expenses/providers/expense_provider.dart';
import 'features/gamification/providers/gamification_provider.dart';
import 'features/habits/providers/habit_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FitRoutineExpenseApp());
}

class FitRoutineExpenseApp extends StatelessWidget {
  const FitRoutineExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GamificationProvider()),
        ChangeNotifierProvider(create: (_) => HabitProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
      ],
      child: MaterialApp(
        title: 'FitRoutine & Expense',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MainNavigationScreen(),
      ),
    );
  }
}
