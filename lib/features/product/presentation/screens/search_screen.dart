import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/common/common_animated_section.dart';
import '../../../../core/common/common_chip.dart';
import '../../../../core/common/common_search_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/common/common_section_header.dart';
import '../widgets/search_category_card.dart';
import '../widgets/search_recent_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> _trendingSearches = [
    'Organic Apple',
    'Fresh Banana',
    'Green Broccoli',
    'Juicy Mango',
    'Red Strawberry',
  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Fruits', 'icon': '🍎', 'color': AppColors.berryPastel},
    {'name': 'Vegetables', 'icon': '🥦', 'color': AppColors.greenPastel},
    {'name': 'Dairy', 'icon': '🥛', 'color': AppColors.tropicalPastel},
    {'name': 'Bakery', 'icon': '🍞', 'color': AppColors.citrusPastel},
    {'name': 'Meat', 'icon': '🥩', 'color': AppColors.berryPastel},
    {'name': 'Seafood', 'icon': '🐟', 'color': AppColors.greenPastel},
  ];

  Widget _buildAnimatedSection(int index, Widget child) {
    return CommonAnimatedSection(index: index, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: CommonSearchBar(
                hintText: 'Search for fresh produce...',
                rightIcon: Icons.close_rounded,
                onRightIconTap: () => Navigator.pop(context),
                showBadge: false,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnimatedSection(
                      0,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonSectionHeader(title: 'Trending Searches'),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _trendingSearches.map((search) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.productListing,
                                  );
                                },
                                child: CommonChip(label: search),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildAnimatedSection(
                      1,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonSectionHeader(title: 'Categories'),
                          const SizedBox(height: 16),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 2.5,
                                ),
                            itemCount: _categories.length,
                            itemBuilder: (context, index) {
                              return SearchCategoryCard(
                                category: _categories[index],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildAnimatedSection(
                      2,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonSectionHeader(title: 'Recently Viewed'),
                          const SizedBox(height: 12),
                          const SearchRecentItem(
                            title: 'Fuji Apple',
                            weight: '1 kg',
                            price: '\$4.20',
                          ),
                          const SearchRecentItem(
                            title: 'Local Banana',
                            weight: '1 bunch',
                            price: '\$2.50',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
