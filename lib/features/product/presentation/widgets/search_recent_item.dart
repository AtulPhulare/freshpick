import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';

class SearchRecentItem extends StatelessWidget {
  final String title;
  final String weight;
  final String price;

  const SearchRecentItem({
    super.key,
    required this.title,
    required this.weight,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.history_rounded, color: AppColors.textGrey),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
      subtitle: Text(weight, style: const TextStyle(color: AppColors.textGrey)),
      trailing: Text(
        price,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.productListing);
      },
    );
  }
}
