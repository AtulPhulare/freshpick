import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshpick/core/constants/app_colors.dart';
import '../widgets/product_detail_widgets.dart';

class ProductDetailsPage extends StatefulWidget {
  final String? imageUrl;
  const ProductDetailsPage({super.key, this.imageUrl});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with TickerProviderStateMixin {
  int quantity = 1;
  bool isFavorite = false;
  bool showFullDescription = false;
  int _selectedVariant = 1;
  bool _addedToCart = false;

  late AnimationController _entryCtrl;
  late AnimationController _cartCtrl;
  late Animation<double> _fadeAnim;
  late Animation<double> _cartScale;

  final List<Map<String, String>> _variants = [
    {'label': '250g', 'price': '6.99'},
    {'label': '500g', 'price': '11.99'},
    {'label': '1 kg', 'price': '19.99'},
  ];

  @override
  void initState() {
    super.initState();
    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _cartCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _fadeAnim = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut);
    _cartScale = Tween<double>(
      begin: 1.0,
      end: 0.94,
    ).animate(CurvedAnimation(parent: _cartCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    _cartCtrl.dispose();
    super.dispose();
  }

  void _onAddToCart() {
    HapticFeedback.mediumImpact();
    _cartCtrl.forward().then((_) => _cartCtrl.reverse());
    setState(() => _addedToCart = true);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => isFavorite = !isFavorite);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: isFavorite ? AppColors.error : Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Full-bleed hero image
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.46,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Full image
                        Hero(
                          tag:
                              widget.imageUrl ??
                              'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=800&q=80',
                          child: Image.network(
                            widget.imageUrl ??
                                'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=800&q=80',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppColors.primaryLight,
                              child: Icon(
                                Icons.eco_rounded,
                                size: 80,
                                color: AppColors.primary.withValues(alpha: 0.3),
                              ),
                            ),
                          ),
                        ),

                        // Bottom fade into white sheet
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 80,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withValues(alpha: 0.95),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Organic + rating overlays
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: ProductDetailPill(
                            icon: Icons.eco_rounded,
                            label: 'Organic',
                            bg: AppColors.primary,
                            fg: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: ProductDetailPill(
                            icon: Icons.star_rounded,
                            label: '4.8  (234)',
                            bg: Colors.white,
                            fg: AppColors.textDark,
                            iconColor: const Color(0xFFFFC107),
                            shadow: true,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── White content sheet
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name + price row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Fresh Apple',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textDark,
                                      letterSpacing: -0.8,
                                      height: 1.1,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_rounded,
                                        size: 11,
                                        color: AppColors.textGrey,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        'Organic Farm, Himachal Pradesh',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: AppColors.textGrey.withValues(
                                            alpha: 0.8,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${_variants[_selectedVariant]['price']}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primary,
                                    letterSpacing: -1,
                                    height: 1,
                                  ),
                                ),
                                Text(
                                  'per ${_variants[_selectedVariant]['label']}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textGrey.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        // ── Weight variants
                        const Text(
                          'SELECT WEIGHT',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textGrey,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(_variants.length, (i) {
                            final selected = _selectedVariant == i;
                            return GestureDetector(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                setState(() => _selectedVariant = i);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppColors.primary
                                      : const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: selected
                                      ? [
                                          BoxShadow(
                                            color: AppColors.primary.withValues(
                                              alpha: 0.3,
                                            ),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Text(
                                  _variants[i]['label']!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: selected
                                        ? Colors.white
                                        : AppColors.textGrey,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 22),

                        // ── Nutrition strip
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F9F5),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ProductNutritionTile(
                                icon: Icons.local_fire_department_rounded,
                                value: '52 kcal',
                                label: 'Calories',
                                color: const Color(0xFFFF6B35),
                              ),
                              const ProductVerticalDivider(),
                              ProductNutritionTile(
                                icon: Icons.water_drop_rounded,
                                value: '86%',
                                label: 'Water',
                                color: const Color(0xFF2196F3),
                              ),
                              const ProductVerticalDivider(),
                              ProductNutritionTile(
                                icon: Icons.grass_rounded,
                                value: '2.4g',
                                label: 'Fiber',
                                color: AppColors.primary,
                              ),
                              const ProductVerticalDivider(),
                              ProductNutritionTile(
                                icon: Icons.science_rounded,
                                value: '14g',
                                label: 'Carbs',
                                color: const Color(0xFFFFC107),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 22),

                        // ── Description
                        const Text(
                          'ABOUT THIS PRODUCT',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textGrey,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Text(
                            showFullDescription
                                ? 'Hand-picked from certified organic farms in Himachal Pradesh. Our Fuji apples are grown without synthetic pesticides and are crisp, sweet, and full of natural goodness. Rich in Vitamin C, dietary fiber, and antioxidants — a perfect healthy snack for the whole family. Harvested at peak ripeness and delivered fresh to your doorstep within 24 hours of picking.'
                                : 'Hand-picked from certified organic farms in Himachal Pradesh. Our Fuji apples are grown without synthetic pesticides and are crisp, sweet...',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textGrey.withValues(alpha: 0.85),
                              height: 1.7,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () => setState(
                            () => showFullDescription = !showFullDescription,
                          ),
                          child: Row(
                            children: [
                              Text(
                                showFullDescription ? 'Show less' : 'Read more',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                showFullDescription
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                size: 18,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ── Delivery info
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.delivery_dining_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Free delivery on orders over \$30',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  Text(
                                    'Estimated delivery: Today, 2–4 PM',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textGrey.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Spacer for bottom bar
                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Floating bottom bar
            Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomBar()),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Qty stepper
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProductQtyButton(
                  icon: quantity == 1
                      ? Icons.delete_outline_rounded
                      : Icons.remove_rounded,
                  color: quantity == 1 ? AppColors.error : AppColors.primary,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    if (quantity > 1) setState(() => quantity--);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                ProductQtyButton(
                  icon: Icons.add_rounded,
                  color: AppColors.primary,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => quantity++);
                  },
                  filled: true,
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          // Add to cart
          Expanded(
            child: ScaleTransition(
              scale: _cartScale,
              child: GestureDetector(
                onTap: _onAddToCart,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 280),
                  height: 52,
                  decoration: BoxDecoration(
                    color: _addedToCart
                        ? const Color(0xFF1B5E20)
                        : AppColors.primary,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _addedToCart
                            ? Icons.check_rounded
                            : Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _addedToCart ? 'Added to Cart!' : 'Add to Cart',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
