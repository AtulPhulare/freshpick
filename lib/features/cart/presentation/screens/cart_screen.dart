import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshpick/features/cart/presentation/widgets/checkout_bottomsheet.dart';
import '../../../../core/common/common_animated_section.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/model/cart_model.dart';
import '../widgets/cart_card.dart';
import '../../../../core/common/common_empty_state.dart';
import '../widgets/cart_dismiss_background.dart';
import '../widgets/promo_row.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartModel> _items = [
    CartModel(
      name: 'Fresh Apple',
      imageUrl:
          'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=200&q=80',
      unit: '500 g',
      pastel: AppColors.berryPastel,
      price: 3.99,
      qty: 2,
    ),
    CartModel(
      name: 'Banana Bunch',
      imageUrl:
          'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=200&q=80',
      unit: '1 kg',
      pastel: AppColors.tropicalPastel,
      price: 2.49,
      qty: 3,
    ),
    CartModel(
      name: 'Sweet Orange',
      imageUrl:
          'https://images.unsplash.com/photo-1580052614034-c55d20bfee3b?w=200&q=80',
      unit: '750 g',
      pastel: AppColors.citrusPastel,
      price: 4.99,
      qty: 1,
    ),
    CartModel(
      name: 'Strawberry',
      imageUrl:
          'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=200&q=80',
      unit: '250 g',
      pastel: AppColors.berryPastel,
      price: 6.99,
      qty: 2,
    ),
    CartModel(
      name: 'Watermelon',
      imageUrl:
          'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=200&q=80',
      unit: 'per piece',
      pastel: AppColors.greenPastel,
      price: 8.99,
      qty: 1,
    ),
  ];

  static const double _deliveryFee = 2.49;
  static const double _discount = 3.00;

  double get _subtotal => _items.fold(0, (s, i) => s + i.price * i.qty);
  double get _total => _subtotal + _deliveryFee - _discount;

  void _changeQty(int index, int delta) {
    HapticFeedback.selectionClick();
    setState(() {
      final newQty = _items[index].qty + delta;
      if (newQty <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].qty = newQty;
      }
    });
  }

  void _removeItem(int index) {
    HapticFeedback.mediumImpact();
    setState(() => _items.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAnimatedSection(
              index: 0,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Your Cart',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textDark,
                    letterSpacing: -1,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  if (_items.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: PromoRow(),
                    ),

                  Expanded(
                    child: _items.isEmpty
                        ? CommonEmptyState(
                            icon: Icons.shopping_cart_outlined,
                            title: 'Your cart is empty',
                            subtitle: 'Add some fresh items to get started!',
                            buttonText: 'Start Shopping',
                            onButtonPressed: () {},
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(20, 4, 20, 280),
                            itemCount: _items.length,
                            itemBuilder: (ctx, i) => CommonAnimatedSection(
                              index: i + 1,
                              child: Dismissible(
                                key: ValueKey('${_items[i].name}_$i'),
                                direction: DismissDirection.endToStart,
                                background: const CartDismissBackground(),
                                onDismissed: (_) => _removeItem(i),
                                child: CartCard(
                                  item: _items[i],
                                  onIncrement: () => _changeQty(i, 1),
                                  onDecrement: () => _changeQty(i, -1),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _items.isEmpty
          ? null
          : CheckoutBottomSheet(
              subtotal: _subtotal,
              deliveryFee: _deliveryFee,
              discount: _discount,
              total: _total,
            ),
    );
  }
}
