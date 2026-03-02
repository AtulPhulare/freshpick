import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';

class SearchCategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;

  const SearchCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.productListing);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: category['color'],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(category['icon'], style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Text(
              category['name'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
