
import 'dart:ui';

class WishlistModel {
  final String name;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final String weight;
  final double rating;
  final int reviews;
  final Color cardColor;
  final String tag;

  const WishlistModel({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.weight,
    required this.rating,
    required this.reviews,
    required this.cardColor,
    required this.tag,
  });

  int get discountPct =>
      (((originalPrice - price) / originalPrice) * 100).round();
}
