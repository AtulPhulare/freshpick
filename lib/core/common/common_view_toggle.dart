import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'common_toggle_button.dart';

class CommonViewToggle extends StatelessWidget {
  final bool isGridView;
  final ValueChanged<bool> onToggle;

  const CommonViewToggle({
    super.key,
    required this.isGridView,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonToggleButton(
            icon: Icons.grid_view_rounded,
            isActive: isGridView,
            onTap: () => onToggle(true),
          ),
          CommonToggleButton(
            icon: Icons.view_list_rounded,
            isActive: !isGridView,
            onTap: () => onToggle(false),
          ),
        ],
      ),
    );
  }
}
