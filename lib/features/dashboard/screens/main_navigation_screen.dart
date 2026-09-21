import 'package:material_ui/material_ui.dart';
import '../../../core/constants/app_colors.dart';
import '../../expenses/screens/expense_screen.dart';
import '../../habits/screens/habit_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../stats/screens/stats_screen.dart';
import 'dashboard_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(onTabSelected: _onTabSelected),
      const HabitScreen(),
      const ExpenseScreen(),
      const StatsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onTabSelected,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primary.withValues(alpha: 0.25),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: AppColors.primaryLight),
            label: 'Tổng quan',
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon:
                Icon(Icons.checklist_rounded, color: AppColors.primaryLight),
            label: 'Thói quen',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet_rounded,
                color: AppColors.primaryLight),
            label: 'Thu chi',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon:
                Icon(Icons.bar_chart_rounded, color: AppColors.primaryLight),
            label: 'Thống kê',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon:
                Icon(Icons.person_rounded, color: AppColors.primaryLight),
            label: 'Nhóm 11',
          ),
        ],
      ),
    );
  }
}
