import 'package:flutter/material.dart';
import '../../../../core/common/common_animated_section.dart';
import '../../../../core/common/common_empty_state.dart';
import '../../../../core/common/common_header.dart';
import '../../../../core/common/common_textfield.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dummy_data.dart';
import '../widgets/shop_card.dart';

class ShopListingScreen extends StatefulWidget {
  const ShopListingScreen({super.key});

  @override
  State<ShopListingScreen> createState() => _ShopListingScreenState();
}

class _ShopListingScreenState extends State<ShopListingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedType = 'All';
  String _query = '';

  List<String> get _types => [
    'All',
    ...{for (final shop in DummyData.shops) shop['type'] as String},
  ];

  List<Map<String, dynamic>> get _filteredShops {
    return DummyData.shops.where((shop) {
      final matchesType =
          _selectedType == 'All' || shop['type'] == _selectedType;
      final matchesQuery = (shop['name'] as String).toLowerCase().contains(
        _query.toLowerCase(),
      );
      return matchesType && matchesQuery;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shops = _filteredShops;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CommonHeader(title: 'Nearby Shops'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: CommonTextField(
                controller: _searchController,
                hintText: 'Search shops',
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.primary,
                ),
                textInputAction: TextInputAction.search,
                onChanged: (value) => setState(() => _query = value.trim()),
              ),
            ),
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _types.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final type = _types[index];
                  return _TypeFilterChip(
                    label: type,
                    isSelected: _selectedType == type,
                    onTap: () => setState(() => _selectedType = type),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${shops.length} shops found',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ),
            Expanded(
              child: shops.isEmpty
                  ? const CommonEmptyState(
                      icon: Icons.storefront_outlined,
                      title: 'No shops found',
                      subtitle: 'Try a different search or category',
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      itemCount: shops.length,
                      itemBuilder: (context, index) {
                        return CommonAnimatedSection(
                          index: index,
                          child: ShopCard(shop: shops[index], onTap: () {}),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.15),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
            color: isSelected ? AppColors.white : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
