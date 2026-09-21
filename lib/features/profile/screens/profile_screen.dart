import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../gamification/providers/gamification_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cá Nhân & Nhóm Phát Triển'),
      ),
      body: Consumer<GamificationProvider>(
        builder: (context, gameProv, child) {
          final state = gameProv.state;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              // User Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.surfaceLight),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primaryLight,
                      child: const Text(
                        'HP',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nguyễn Hồng Phúc',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${state.title} • Cấp ${state.level}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Badges Section
              const Text(
                'Huy Hiệu Đạt Được',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBadgeItem('🔥', '3 Ngày Streak', true),
                  _buildBadgeItem('💰', 'Tiết Kiệm Giỏi', true),
                  _buildBadgeItem('🎯', 'Kỷ Luật Thép', false),
                  _buildBadgeItem('👑', 'Bậc Thầy', false),
                ],
              ),
              const SizedBox(height: 24),

              // Group 11 Project Information
              const Text(
                'Đội Ngũ Thực Hiện - GROUP 11',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.surfaceLight),
                ),
                child: Column(
                  children: [
                    _buildMemberTile(
                      name: 'Nguyễn Hồng Phúc (Trưởng nhóm)',
                      mssv: '2351170611',
                      role: 'Lead Dev & System Architect',
                      tagColor: AppColors.primary,
                      isLeader: true,
                    ),
                    const Divider(height: 1, color: AppColors.surfaceLight),
                    _buildMemberTile(
                      name: 'Lê Tuấn Khanh',
                      mssv: '2351170601',
                      role: 'Core Feature Dev (Habits & Expenses)',
                      tagColor: AppColors.secondary,
                    ),
                    const Divider(height: 1, color: AppColors.surfaceLight),
                    _buildMemberTile(
                      name: 'Đinh Thị Hoa',
                      mssv: '2351170593',
                      role: 'UI/UX Designer & BA (Tài liệu Báo cáo)',
                      tagColor: AppColors.xpGold,
                    ),
                    const Divider(height: 1, color: AppColors.surfaceLight),
                    _buildMemberTile(
                      name: 'PHẠM VŨ NGỌC BẢO',
                      mssv: '2251172249',
                      role: 'QA Tester, Slide & Thuyết trình',
                      tagColor: AppColors.accent,
                    ),
                    const Divider(height: 1, color: AppColors.surfaceLight),
                    _buildMemberTile(
                      name: 'CHU HỮU ĐỆ',
                      mssv: '2251172273',
                      role: 'Junior Dev & UI Coder',
                      tagColor: AppColors.info,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'FitRoutine & Expense v1.0.0 • Môn Lập trình ĐTDĐ',
                  style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  static Widget _buildBadgeItem(String emoji, String title, bool unlocked) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: unlocked
                ? AppColors.primary.withValues(alpha: 0.2)
                : AppColors.surfaceLight.withValues(alpha: 0.3),
            shape: BoxShape.circle,
            border: Border.all(
              color: unlocked ? AppColors.primaryLight : AppColors.surfaceLight,
            ),
          ),
          child: Center(
            child: Text(
              emoji,
              style: TextStyle(
                fontSize: 26,
                color: unlocked ? null : Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: unlocked ? AppColors.textPrimary : AppColors.textMuted,
            fontWeight: unlocked ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  static Widget _buildMemberTile({
    required String name,
    required String mssv,
    required String role,
    required Color tagColor,
    bool isLeader = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: tagColor.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isLeader ? Icons.star_rounded : Icons.person_outline_rounded,
          color: tagColor,
          size: 20,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isLeader ? FontWeight.bold : FontWeight.w600,
          color: isLeader ? AppColors.xpGold : AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        'MSSV: $mssv\n$role',
        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
      ),
      isThreeLine: true,
    );
  }
}
