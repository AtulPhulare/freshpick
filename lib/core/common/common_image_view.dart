import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CommonImageView extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double borderRadius;

  const CommonImageView({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        url,
        height: height,
        width: width,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: height,
            width: width,
            color: AppColors.background,
            child: const Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: height,
            width: width,
            color: AppColors.background,
            child: const Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: AppColors.textGrey,
                size: 24,
              ),
            ),
          );
        },
      ),
    );
  }
}
