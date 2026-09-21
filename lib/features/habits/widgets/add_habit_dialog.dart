import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/habit_provider.dart';

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({super.key});

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  final List<IconData> _icons = [
    Icons.fitness_center_rounded,
    Icons.water_drop_rounded,
    Icons.menu_book_rounded,
    Icons.savings_rounded,
    Icons.bedtime_rounded,
    Icons.code_rounded,
    Icons.directions_run_rounded,
    Icons.self_improvement_rounded,
  ];

  final List<Color> _colors = [
    const Color(0xFF6C5CE7),
    const Color(0xFF00CEC9),
    const Color(0xFFFF7675),
    const Color(0xFF00B894),
    const Color(0xFFFDCB6E),
    const Color(0xFF0984E3),
  ];

  late IconData _selectedIcon;
  late Color _selectedColor;
  int _xpReward = 20;

  @override
  void initState() {
    super.initState();
    _selectedIcon = _icons[0];
    _selectedColor = _colors[0];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.add_task_rounded, color: AppColors.primaryLight),
          SizedBox(width: 8),
          Text(
            'Thêm Thói Quen Mới',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Tên thói quen *',
                hintText: 'VD: Dậy sớm lúc 6:00',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Mô tả / Mục tiêu',
                hintText: 'VD: Khởi đầu ngày mới tràn đầy năng lượng',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Chọn biểu tượng:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _icons.map((icon) {
                final isSelected = _selectedIcon == icon;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIcon = icon),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Điểm EXP thưởng khi hoàn thành:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            Slider(
              value: _xpReward.toDouble(),
              min: 10,
              max: 50,
              divisions: 8,
              activeColor: AppColors.xpGold,
              label: '+$_xpReward XP',
              onChanged: (val) => setState(() => _xpReward = val.round()),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy', style: TextStyle(color: AppColors.textMuted)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          onPressed: () {
            if (_titleController.text.trim().isEmpty) return;

            context.read<HabitProvider>().addHabit(
                  title: _titleController.text.trim(),
                  description: _descController.text.trim(),
                  icon: _selectedIcon,
                  color: _selectedColor,
                  xpReward: _xpReward,
                );
            Navigator.pop(context);
          },
          child: const Text('Tạo ngay', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
