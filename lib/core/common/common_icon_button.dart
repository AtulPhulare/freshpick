import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CommonIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  final double? size;
  final double? iconSize;

  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;

  final bool showBadge;
  final int badgeCount;
  final Color? badgeColor;
  final Color? badgeBorderColor;
  final double? badgeBorderWidth;

  final double? borderRadius;

  const CommonIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size,
    this.iconSize,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.showBadge = false,
    this.badgeCount = 0,
    this.badgeColor,
    this.badgeBorderColor,
    this.badgeBorderWidth,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final containerSize = size ?? 50;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
          border: Border.all(
            color: borderColor ?? AppColors.primary.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              color: iconColor ?? AppColors.white,
              size: iconSize ?? 22,
            ),
            if (showBadge && badgeCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: badgeColor ?? AppColors.accent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: badgeBorderColor ?? AppColors.white,
                      width: badgeBorderWidth ?? 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      badgeCount > 99 ? '99+' : '$badgeCount',
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
