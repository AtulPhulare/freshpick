import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class QtyStepper extends StatelessWidget {
  final int qty;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QtyStepper({
    super.key,
    required this.qty,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final isOne = qty == 1;

    return Container(
      width: 34,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Add button
          _StepBtn(
            icon: Icons.add_rounded,
            onTap: onIncrement,
            color: AppColors.primary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
          ),

          // ── Divider
          Container(
            height: 0.5,
            color: AppColors.primary.withValues(alpha: 0.12),
          ),

          // ── Qty label
          SizedBox(
            height: 30,
            child: Center(
              child: Text(
                '$qty',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
            ),
          ),

          // ── Divider
          Container(
            height: 0.5,
            color: AppColors.primary.withValues(alpha: 0.12),
          ),

          // ── Remove / Delete button
          _StepBtn(
            icon: isOne ? Icons.delete_outline_rounded : Icons.remove_rounded,
            onTap: onDecrement,
            color: isOne ? AppColors.error : AppColors.primary,
            isDestructive: isOne,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(13),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final bool isDestructive;
  final BorderRadius borderRadius;

  const _StepBtn({
    required this.icon,
    required this.onTap,
    required this.color,
    required this.borderRadius,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 34,
        height: 30,
        decoration: BoxDecoration(
          color: isDestructive
              ? AppColors.error.withValues(alpha: 0.1)
              : AppColors.white,
          borderRadius: borderRadius,
        ),
        child: Icon(icon, color: color, size: 15),
      ),
    );
  }
}
