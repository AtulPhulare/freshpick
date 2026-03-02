import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CommonChip extends StatelessWidget {
  final String label;
  final Color iconColor;
  final double elevation;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final IconData icon;

  const CommonChip({
    super.key,
    required this.label,
    this.iconColor = AppColors.error,
    this.elevation = 3,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.icon = Icons.location_on_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation,
      borderRadius: borderRadius,
      shadowColor: Colors.black26,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
