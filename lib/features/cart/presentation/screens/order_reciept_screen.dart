import 'package:flutter/material.dart';
import 'package:freshpick/core/common/common_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../config/routes/app_routes.dart';

class OrderRecieptScreen extends StatefulWidget {
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;

  const OrderRecieptScreen({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
  });

  @override
  State<OrderRecieptScreen> createState() => _OrderRecieptScreenState();
}

class _OrderRecieptScreenState extends State<OrderRecieptScreen>
    with TickerProviderStateMixin {
  late AnimationController _checkController;
  late AnimationController _receiptController;
  late Animation<double> _checkScale;
  late Animation<double> _receiptSlide;
  late Animation<double> _receiptOpacity;

  @override
  void initState() {
    super.initState();

    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _receiptController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _checkScale = CurvedAnimation(
      parent: _checkController,
      curve: Curves.elasticOut,
    );
    _receiptSlide = Tween<double>(begin: 80, end: 0).animate(
      CurvedAnimation(parent: _receiptController, curve: Curves.easeOutCubic),
    );
    _receiptOpacity = CurvedAnimation(
      parent: _receiptController,
      curve: Curves.easeIn,
    );

    // stagger: check first, then receipt slides up
    _checkController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _receiptController.forward();
      });
    });
  }

  @override
  void dispose() {
    _checkController.dispose();
    _receiptController.dispose();
    super.dispose();
  }

  String _todayDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/'
        '${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppColors.primary),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),

              // ── Animated success check
              ScaleTransition(
                scale: _checkScale,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.3),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.primary,
                    size: 44,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              const Text(
                'Order Placed!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Your fresh items are on their way 🌿',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 24),

              // ── Animated receipt card
              Expanded(
                child: AnimatedBuilder(
                  animation: _receiptController,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, _receiptSlide.value),
                    child: Opacity(
                      opacity: _receiptOpacity.value,
                      child: child,
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDF5),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // ── Perforated top
                          _PerforatedEdge(isTop: true),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                            child: Column(
                              children: [
                                // ── Store header
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.eco_rounded,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'FRESHMART',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.textDark,
                                        letterSpacing: 4,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Fresh from Farm to You',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: AppColors.textGrey.withValues(
                                      alpha: 0.7,
                                    ),
                                    letterSpacing: 1.5,
                                  ),
                                ),

                                const SizedBox(height: 12),
                                _DashedLine(),
                                const SizedBox(height: 10),

                                // ── Order meta
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _MetaText(
                                      label: 'ORDER NO.',
                                      value: '#FRM-2847',
                                    ),
                                    _MetaText(
                                      label: 'DATE',
                                      value: _todayDate(),
                                      alignRight: true,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _MetaText(
                                      label: 'DELIVERY',
                                      value: 'Today, 2–4 PM',
                                    ),
                                    _MetaText(
                                      label: 'PAYMENT',
                                      value: 'Card ••••4242',
                                      alignRight: true,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),
                                _DashedLine(),
                                const SizedBox(height: 10),

                                // ── Column headers
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'ITEM',
                                        style: TextStyle(
                                          fontSize: 9,
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textGrey,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'QTY',
                                      style: TextStyle(
                                        fontSize: 9,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textGrey,
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    const Text(
                                      'AMT',
                                      style: TextStyle(
                                        fontSize: 9,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textGrey,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),
                                _DashedLine(),
                                const SizedBox(height: 8),

                                // ── Hardcoded line items
                                // (in real app, pass cartItems through)
                                _LineItem('Fresh Apple', '2', '\$7.98'),
                                _LineItem('Banana', '3', '\$7.47'),
                                _LineItem('Sweet Orange', '1', '\$4.99'),
                                _LineItem('Strawberry', '2', '\$13.98'),
                                _LineItem('Watermelon', '1', '\$8.99'),

                                const SizedBox(height: 8),
                                _DashedLine(),
                                const SizedBox(height: 10),

                                // ── Subtotals
                                _ReceiptRow(
                                  label: 'Subtotal',
                                  value:
                                      '\$${widget.subtotal.toStringAsFixed(2)}',
                                ),
                                const SizedBox(height: 5),
                                _ReceiptRow(
                                  label: 'Delivery Fee',
                                  value:
                                      '\$${widget.deliveryFee.toStringAsFixed(2)}',
                                ),
                                const SizedBox(height: 5),
                                _ReceiptRow(
                                  label: 'Discount',
                                  value:
                                      '-\$${widget.discount.toStringAsFixed(2)}',
                                  valueColor: AppColors.error,
                                ),

                                const SizedBox(height: 10),

                                // ── Total
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'TOTAL PAID',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.textDark,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      Text(
                                        '\$${widget.total.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.primary,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // ── Barcode
                                _BarcodeDecoration(),
                                const SizedBox(height: 6),
                                Text(
                                  '* THANK YOU FOR SHOPPING *',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: AppColors.textGrey.withValues(
                                      alpha: 0.55,
                                    ),
                                    letterSpacing: 1.8,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),

                          // ── Perforated bottom
                          _PerforatedEdge(isTop: false),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ── Navigation buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Column(
                  children: [
                    CommonButton(
                      backgroundColor: AppColors.white,
                      text: 'Track Order',
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.orderTracking);
                      },
                      textColor: AppColors.primary,
                      icon: Icons.local_shipping_outlined,
                    ),
                    const SizedBox(height: 12),
                    CommonButton(
                      backgroundColor: AppColors.white,
                      text: 'Back To Shop',
                      icon: Icons.shopping_cart_outlined,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      textColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Line item row (item name | qty | amount)
class _LineItem extends StatelessWidget {
  final String name, qty, amount;
  const _LineItem(this.name, this.qty, this.amount);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
          Text(
            qty,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              amount,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PerforatedEdge extends StatelessWidget {
  final bool isTop;
  const _PerforatedEdge({required this.isTop});

  static const double _r = 8;
  static const double _spacing = 20;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final int count = (width / _spacing).floor();
        // Distribute evenly across full width, first and last circle flush to edges
        final double gap = (width - _r * 2) / (count - 1);

        return SizedBox(
          height: _r,
          child: Stack(
            clipBehavior: Clip.none,
            children: List.generate(count, (i) {
              final double cx = i * gap; // left edge of each circle
              return Positioned(
                left: cx,
                top: isTop ? -_r : -1,
                child: Container(
                  width: _r * 2,
                  height: _r * 2,
                  decoration: BoxDecoration(
                    color: isTop ? AppColors.primary : const Color(0xFFFFFDF5),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

// ── Dashed horizontal line
class _DashedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        40,
        (i) => Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            height: 1,
            color: i.isEven
                ? AppColors.textGrey.withValues(alpha: 0.25)
                : Colors.transparent,
          ),
        ),
      ),
    );
  }
}

// ── Single receipt line row
class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _ReceiptRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textGrey,
            letterSpacing: 0.3,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: valueColor ?? AppColors.textDark,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

// ── Order meta label+value pair
class _MetaText extends StatelessWidget {
  final String label;
  final String value;
  final bool alignRight;

  const _MetaText({
    required this.label,
    required this.value,
    this.alignRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignRight
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            letterSpacing: 1.5,
            color: AppColors.textGrey.withValues(alpha: 0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// ── Fake barcode visual
class _BarcodeDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final random = [
      3,
      1,
      4,
      2,
      5,
      1,
      3,
      2,
      4,
      1,
      5,
      3,
      2,
      4,
      1,
      3,
      5,
      2,
      4,
      1,
      3,
      2,
      5,
      1,
      4,
      3,
      2,
      5,
      1,
      4,
      3,
      2,
    ];
    return SizedBox(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: random.map((w) {
          return Container(
            width: w.toDouble(),
            margin: const EdgeInsets.symmetric(horizontal: 0.8),
            decoration: BoxDecoration(
              color: AppColors.textDark.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(0.5),
            ),
          );
        }).toList(),
      ),
    );
  }
}
