import 'package:flutter/material.dart';
import '../../../../core/common/common_product_card_vertical.dart';
import '../../../../core/common/common_product_card_horizontal.dart';

class ProductListingGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const ProductListingGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 12,
        childAspectRatio: 0.60,
      ),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];

        return CommonProductCardVertical(
          imageUrl: item['imageUrl'],
          title: item['name'],
          tag: item['isOrganic'] ? 'Organic' : 'Fresh',
          rating: item['rating'],
          reviews: item['reviewCount'],
          price: item['price'],
          originalPrice: item['price'] + 3,
          discountPercent: 15,
          onAddToCart: () {},
          onFavorite: () {},
        );
      },
    );
  }
}

class ProductListingList extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const ProductListingList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];

        return CommonProductCardHorizontal(
          imageUrl: item['imageUrl'],
          title: item['name'],
          tag: item['isOrganic'] ? 'Organic' : 'Fresh',
          rating: item['rating'],
          reviews: item['reviewCount'],
          weight: item['weight'],
          price: item['price'],
          originalPrice: item['price'] + 3,
          discountPercent: 15,
          onAddToCart: () {},
          onFavorite: () {},
        );
      },
    );
  }
}
