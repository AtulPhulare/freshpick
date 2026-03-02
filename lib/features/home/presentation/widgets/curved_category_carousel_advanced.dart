import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class CategoryItem {
  final String imageUrl;
  final String label;

  CategoryItem({required this.imageUrl, required this.label});
}

class CurvedCategoryCarouselAdvanced extends StatefulWidget {
  final List<CategoryItem> categories;

  const CurvedCategoryCarouselAdvanced({super.key, required this.categories});

  @override
  State<CurvedCategoryCarouselAdvanced> createState() =>
      _CurvedCategoryCarouselAdvancedState();
}

class _CurvedCategoryCarouselAdvancedState
    extends State<CurvedCategoryCarouselAdvanced> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  final List<String> offerImages = [
    // Fresh mixed fruits overhead
    'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=1200&q=80',
    // Colourful vegetable market
    'https://images.unsplash.com/photo-1542838132-92c53300491e?w=1200&q=80',
    // Tropical fruits flat lay
    'https://images.unsplash.com/photo-1490474418585-ba9bad8fd0ea?w=1200&q=80',
    // Fresh strawberries close-up
    'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=1200&q=80',
    // Watermelon slices
    'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=1200&q=80',
    // Citrus fruits overhead
    'https://images.unsplash.com/photo-1557800636-894a64c1696f?w=1200&q=80',
  ];

  static final List<CategoryItem> defaultCategories = [
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=200&q=80',
      label: 'Apples',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=200&q=80',
      label: 'Bananas',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1580052614034-c55d20bfee3b?w=200&q=80',
      label: 'Oranges',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=200&q=80',
      label: 'Berries',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=200&q=80',
      label: 'Melon',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=200&q=80',
      label: 'Mango',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=200&q=80',
      label: 'Potato',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1603833665858-e61d17a86224?w=200&q=80',
      label: 'Kiwi',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=200&q=80',
      label: 'Grapes',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1589927986089-35812388d1f4?w=200&q=80',
      label: 'Lemon',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_pageController.hasClients) return;
      _currentPage = (_currentPage + 1) % offerImages.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final containerHeight = MediaQuery.of(context).size.height * 0.32;
    final categories = widget.categories.isNotEmpty
        ? widget.categories
        : defaultCategories;

    return SizedBox(
      height: containerHeight + 100,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Banner image slider
          SizedBox(
            height: containerHeight,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: PageView.builder(
                controller: _pageController,
                itemCount: offerImages.length,
                onPageChanged: (index) => _currentPage = index,
                itemBuilder: (context, index) {
                  return Image.network(
                    offerImages[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) =>
                        const Center(child: Icon(Icons.broken_image, size: 40)),
                  );
                },
              ),
            ),
          ),

          // ── Gradient overlay that fades out only the very bottom edge, hiding the curve
          Positioned(
            left: 0,
            right: 0,
            top: containerHeight * 0.75,
            height: containerHeight * 0.25,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.6, 1.0],
                  colors: [
                    Theme.of(
                      context,
                    ).scaffoldBackgroundColor.withValues(alpha: 0.0),
                    Theme.of(
                      context,
                    ).scaffoldBackgroundColor.withValues(alpha: 0.85),
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                ),
              ),
            ),
          ),
          // ── Category carousel
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(top: containerHeight - 77),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(categories.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: _buildCategoryItem(
                      categories[index].imageUrl,
                      categories[index].label,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String imageUrl, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 77,
          height: 77,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  width: 69,
                  height: 69,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.18),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.45),
                        blurRadius: 6,
                        spreadRadius: -2,
                        offset: const Offset(-3, -3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      frameBuilder:
                          (ctx, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded || frame != null) {
                              return AnimatedOpacity(
                                opacity: 1.0,
                                duration: const Duration(milliseconds: 300),
                                child: child,
                              );
                            }
                            return Container(
                              color: AppColors.primaryLight,
                              child: Center(
                                child: Icon(
                                  Icons.eco_rounded,
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  size: 24,
                                ),
                              ),
                            );
                          },
                      errorBuilder: (ctx, _, __) => Container(
                        color: AppColors.primaryLight,
                        child: Center(
                          child: Icon(
                            Icons.eco_rounded,
                            color: AppColors.primary.withValues(alpha: 0.4),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            shadows: [
              Shadow(
                color: AppColors.primary.withValues(alpha: 0.08),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
