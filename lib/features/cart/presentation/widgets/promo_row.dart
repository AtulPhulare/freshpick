import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'promo_chip.dart';

class PromoRow extends StatelessWidget {
  const PromoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        scrollDirection: Axis.horizontal,
        children: [
          PromoChip(
            icon: Icons.local_offer_rounded,
            label: 'FRESH10  •  Applied',
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          PromoChip(
            icon: Icons.delivery_dining_rounded,
            label: 'Free delivery over \$30',
            color: AppColors.accent,
          ),
        ],
      ),
    );
  }
}
