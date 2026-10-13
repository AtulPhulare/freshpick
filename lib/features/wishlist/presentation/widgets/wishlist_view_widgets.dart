import 'package:flutter/material.dart';
import '../../../../core/common/common_product_card_horizontal.dart';
import '../../../../core/common/common_product_card_vertical.dart';
import '../../data/model/wishlist_model.dart';

class WishlistGrid extends StatelessWidget {
  final List<WishlistModel> items;
  final void Function(int) onRemove;
  final void Function(WishlistModel) onAddToCart;

  const WishlistGrid({
    super.key,
    required this.items,
    required this.onRemove,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // Fixed height so the card content fits on every screen width
        mainAxisExtent: 290,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];

        return CommonProductCardVertical(
          imageUrl: item.imageUrl,
          title: item.name,
          tag: item.tag,
          rating: item.rating,
          reviews: item.reviews,
          price: item.price,
          originalPrice: item.originalPrice,
          discountPercent: item.discountPct,
          placeholderColor: item.cardColor,
          onFavorite: () => onRemove(i),
          onAddToCart: () => onAddToCart(item),
        );
      },
    );
  }
}

class WishlistList extends StatelessWidget {
  final List<WishlistModel> items;
  final void Function(int) onRemove;
  final void Function(WishlistModel) onAddToCart;

  const WishlistList({
    super.key,
    required this.items,
    required this.onRemove,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];

        return CommonProductCardHorizontal(
          imageUrl: item.imageUrl,
          title: item.name,
          tag: item.tag,
          rating: item.rating,
          reviews: item.reviews,
          weight: item.weight,
          price: item.price,
          originalPrice: item.originalPrice,
          discountPercent: item.discountPct,
          placeholderColor: item.cardColor,
          onFavorite: () => onRemove(i),
          onAddToCart: () => onAddToCart(item),
          onTap: () {},
        );
      },
    );
  }
}
