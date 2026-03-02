import 'package:flutter/material.dart';

import '../../config/routes/app_routes.dart';
import '../constants/app_colors.dart';
import 'common_chip.dart';
import 'common_icon_button.dart';
import 'common_image_view.dart';

class CommonProductCardVertical extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String tag;
  final double rating;
  final int reviews;
  final double price;
  final double originalPrice;
  final int? discountPercent;
  final Color? placeholderColor;

  final VoidCallback? onFavorite;
  final VoidCallback? onAddToCart;

  const CommonProductCardVertical({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.tag,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.originalPrice,
    this.discountPercent,
    this.placeholderColor,
    this.onFavorite,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.productDetail,
        arguments: imageUrl,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            Expanded(child: _buildInfoSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: SizedBox(
            height: 140,
            width: double.infinity,
            child: Hero(
              tag: imageUrl,
              child: CommonImageView(
                url: imageUrl,
                fit: BoxFit.cover,
                height: 140,
                width: double.infinity,
              ),
            ),
          ),
        ),

        /// Favorite Button
        if (onFavorite != null)
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: onFavorite,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: AppColors.error,
                  size: 17,
                ),
              ),
            ),
          ),

        /// Discount Badge
        if (discountPercent != null && discountPercent! > 0)
          Positioned(
            bottom: 0,
            left: 12,
            child: Transform.translate(
              offset: const Offset(0, 12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '-$discountPercent% OFF',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 18, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonChip(label: tag),
              const SizedBox(height: 5),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 13,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    '$rating',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    ' · '
                    ' ($reviews)',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (originalPrice > price)
                    Text(
                      '\$${originalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textGrey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              if (onAddToCart != null)
                CommonIconButton(
                  icon: Icons.add_shopping_cart_rounded,
                  onTap: onAddToCart!,
                  size: 40,
                  iconSize: 18,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
