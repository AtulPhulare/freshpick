import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/common/common_header.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/common/common_empty_state.dart';
import '../../data/model/wishlist_model.dart';
import '../../../../core/common/common_view_toggle.dart';
import '../widgets/wishlist_view_widgets.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<WishlistModel> _items = [
    WishlistModel(
      name: 'Fresh Apple',
      imageUrl:
          'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=300&q=80',
      price: 3.99,
      originalPrice: 5.49,
      weight: '1 kg',
      rating: 4.5,
      reviews: 128,
      cardColor: AppColors.berryPastel,
      tag: 'Organic',
    ),
    WishlistModel(
      name: 'Golden Banana',
      imageUrl:
          'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=300&q=80',
      price: 2.49,
      originalPrice: 3.29,
      weight: '1 kg',
      rating: 4.8,
      reviews: 256,
      cardColor: AppColors.tropicalPastel,
      tag: 'Best Seller',
    ),
    WishlistModel(
      name: 'Sweet Orange',
      imageUrl:
          'https://images.unsplash.com/photo-1580052614034-c55d20bfee3b?w=300&q=80',
      price: 4.99,
      originalPrice: 6.99,
      weight: '1 kg',
      rating: 4.6,
      reviews: 89,
      cardColor: AppColors.citrusPastel,
      tag: 'Fresh',
    ),
    WishlistModel(
      name: 'Strawberry',
      imageUrl:
          'https://images.unsplash.com/photo-1587393855524-087f83d95bc9?w=300&q=80',
      price: 6.99,
      originalPrice: 8.49,
      weight: '500 g',
      rating: 4.9,
      reviews: 342,
      cardColor: AppColors.berryPastel,
      tag: 'Popular',
    ),
    WishlistModel(
      name: 'Watermelon',
      imageUrl:
          'https://images.unsplash.com/photo-1563114773-84221bd62daa?w=300&q=80',
      price: 8.99,
      originalPrice: 11.99,
      weight: '1 pc',
      rating: 4.7,
      reviews: 167,
      cardColor: AppColors.greenPastel,
      tag: 'Seasonal',
    ),
    WishlistModel(
      name: 'Sweet Grapes',
      imageUrl:
          'https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=300&q=80',
      price: 5.49,
      originalPrice: 7.29,
      weight: '500 g',
      rating: 4.8,
      reviews: 203,
      cardColor: AppColors.berryPastel,
      tag: 'New',
    ),
  ];

  bool _isGridView = true;

  void _removeItem(int index) {
    final item = _items[index];
    HapticFeedback.mediumImpact();
    setState(() => _items.removeAt(index));
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          backgroundColor: AppColors.textDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          content: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  item.imageUrl,
                  width: 28,
                  height: 28,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${item.name} removed',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            label: 'Undo',
            textColor: AppColors.success,
            onPressed: () => setState(() => _items.insert(index, item)),
          ),
        ),
      );
  }

  void _addToCart(WishlistModel item) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          content: Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.white,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                '${item.name} added to cart!',
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonHeader(
              title: 'Your Wishlist',
              trailing: CommonViewToggle(
                isGridView: _isGridView,
                onToggle: (v) => setState(() => _isGridView = v),
              ),
            ),

            // ── Content
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _items.isEmpty
                    ? CommonEmptyState(
                        icon: Icons.favorite_border,
                        title: 'No favourites yet',
                        subtitle: 'Items you like will appear here.',
                        buttonText: 'Browse Items',
                        onButtonPressed: () {},
                      )
                    : _isGridView
                    ? WishlistGrid(
                        key: const ValueKey('grid'),
                        items: _items,
                        onRemove: _removeItem,
                        onAddToCart: _addToCart,
                      )
                    : WishlistList(
                        key: const ValueKey('list'),
                        items: _items,
                        onRemove: _removeItem,
                        onAddToCart: _addToCart,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
