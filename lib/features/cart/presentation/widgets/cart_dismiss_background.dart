import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CartDismissBackground extends StatelessWidget {
  const CartDismissBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.25)),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 22),
      child: const Icon(
        Icons.delete_outline_rounded,
        color: AppColors.error,
        size: 24,
      ),
    );
  }
}
