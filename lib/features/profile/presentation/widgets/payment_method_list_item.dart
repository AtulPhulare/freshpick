import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/common/common_icon_button.dart';

class PaymentMethodListItem extends StatelessWidget {
  final Map<String, dynamic> method;
  final VoidCallback onMoreTap;

  const PaymentMethodListItem({
    super.key,
    required this.method,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCard = method.containsKey('expiry');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: (method['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                method['logo'] as IconData,
                color: method['color'] as Color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        method['type'] as String,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.textDark,
                        ),
                      ),
                      if (method['isDefault'] as bool)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Default',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    method['number'] as String,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: AppColors.textGrey,
                    ),
                  ),
                  if (isCard) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Expires ${method['expiry']}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: AppColors.textGrey.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            CommonIconButton(
              icon: Icons.more_vert_rounded,
              onTap: onMoreTap,
              iconColor: AppColors.textGrey,
              size: 32,
              iconSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
