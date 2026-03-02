import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/model/cart_model.dart';
import 'query_stepper.dart';

class CartCard extends StatelessWidget {
  final CartModel item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Full-bleed image (square, matches card height)
          SizedBox(
            width: 110,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(color: item.pastel),
                Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  frameBuilder: (ctx, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded || frame != null) {
                      return AnimatedOpacity(
                        opacity: 1.0,
                        duration: const Duration(milliseconds: 350),
                        child: child,
                      );
                    }
                    return const SizedBox.expand();
                  },
                  errorBuilder: (ctx, _, __) => Center(
                    child: Icon(
                      Icons.eco_rounded,
                      color: AppColors.primary.withValues(alpha: 0.4),
                      size: 36,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Info section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 4, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Name + unit tag
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.textDark,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      _UnitTag(item.unit),
                    ],
                  ),

                  // Price per unit
                  Text(
                    '\$${item.price.toStringAsFixed(2)} per unit',
                    style: const TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 12,
                    ),
                  ),

                  // Total price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${(item.price * item.qty).toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      if (item.qty > 1) ...[
                        const SizedBox(width: 5),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            '${item.qty} × \$${item.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: AppColors.textGrey.withValues(alpha: 0.65),
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: QtyStepper(
              qty: item.qty,
              onIncrement: onIncrement,
              onDecrement: onDecrement,
            ),
          ),
        ],
      ),
    );
  }
}

class _UnitTag extends StatelessWidget {
  final String label;
  const _UnitTag(this.label);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.18)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: AppColors.primary,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.1,
      ),
    ),
  );
}
