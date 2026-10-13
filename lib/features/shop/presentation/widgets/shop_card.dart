import 'package:flutter/material.dart';
import '../../../../core/common/common_image_view.dart';
import '../../../../core/constants/app_colors.dart';

class ShopCard extends StatelessWidget {
  final Map<String, dynamic> shop;
  final VoidCallback? onTap;

  const ShopCard({super.key, required this.shop, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isOpen = shop['isOpen'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shop Image
              Stack(
                children: [
                  CommonImageView(
                    url: shop['imageUrl'],
                    width: 90,
                    height: 90,
                    borderRadius: 12,
                  ),
                  if (!isOpen)
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Closed',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              // Shop Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            shop['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _ShopTypeBadge(type: shop['type']),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: AppColors.textGrey,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            shop['address'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: AppColors.warning,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${shop['rating']}',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          ' (${shop['reviewCount']})',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: AppColors.textGrey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.near_me_rounded,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${shop['distance']} km',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule_rounded,
                          size: 14,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          shop['deliveryTime'],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColors.textDark,
                          ),
                        ),
                        const Spacer(),
                        if (shop['freeDelivery'])
                          const Text(
                            'Free Delivery',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColors.primary,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShopTypeBadge extends StatelessWidget {
  final String type;

  const _ShopTypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        type,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 10,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
