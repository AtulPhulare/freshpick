import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Compact order tracking steps shown inside an expanded active order.
class OrderTrackingTimeline extends StatelessWidget {
  /// Index of the step currently in progress.
  final int currentStep;
  final List<String> times;

  const OrderTrackingTimeline({
    super.key,
    required this.currentStep,
    required this.times,
  });

  static const _steps = [
    'Order Placed',
    'Order Processing',
    'Out For Delivery',
    'Delivered',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_steps.length, (i) {
        final isCompleted = i < currentStep;
        final isCurrent = i == currentStep;
        final isLast = i == _steps.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted
                          ? AppColors.primary
                          : isCurrent
                          ? AppColors.white
                          : AppColors.background,
                      border: Border.all(
                        color: isCompleted || isCurrent
                            ? AppColors.primary
                            : AppColors.textGrey.withValues(alpha: 0.3),
                        width: isCurrent ? 4 : 1.5,
                      ),
                    ),
                    child: isCompleted
                        ? const Icon(Icons.check, size: 11, color: Colors.white)
                        : null,
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: isCompleted
                            ? AppColors.primary
                            : AppColors.textGrey.withValues(alpha: 0.2),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
                  child: Text(
                    _steps[i],
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 13,
                      color: isCompleted || isCurrent
                          ? AppColors.textDark
                          : AppColors.textGrey,
                    ),
                  ),
                ),
              ),
              Text(
                i < times.length ? times[i] : '--',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
