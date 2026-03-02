import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'common_icon_button.dart';

class CommonHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onBackTap;
  final bool showBackButton;

  const CommonHeader({
    super.key,
    required this.title,
    this.trailing,
    this.onBackTap,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (showBackButton && Navigator.canPop(context))
              Align(
                alignment: Alignment.centerLeft,
                child: CommonIconButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: onBackTap ?? () => Navigator.pop(context),
                  backgroundColor: AppColors.white,
                  iconColor: AppColors.primary,
                  size: 40,
                  iconSize: 18,
                  borderRadius: 12,
                ),
              ),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textDark,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            if (trailing != null)
              Align(alignment: Alignment.centerRight, child: trailing!),
          ],
        ),
      ),
    );
  }
}
