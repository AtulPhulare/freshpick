import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Checkout-style breakdown of an order: items, bill summary,
/// delivery address and payment method.
class OrderDetailsSection extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final List products = order['products'] ?? [];
    final double discount = order['discount'] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Items'),
        const SizedBox(height: 8),
        for (final product in products)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Text(
                  '${product['qty']}×',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    product['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                Text(
                  '\$${(product['qty'] * product['price']).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(color: Color(0xFFEEEEEE), height: 1),
        ),
        _SummaryRow(
          label: 'Subtotal',
          value: '\$${order['subtotal'].toStringAsFixed(2)}',
        ),
        const SizedBox(height: 6),
        _SummaryRow(
          label: 'Delivery fee',
          value: order['deliveryFee'] == 0
              ? 'Free'
              : '\$${order['deliveryFee'].toStringAsFixed(2)}',
        ),
        if (discount > 0) ...[
          const SizedBox(height: 6),
          _SummaryRow(
            label: 'Discount 🏷️',
            value: '-\$${discount.toStringAsFixed(2)}',
            valueColor: AppColors.primary,
          ),
        ],
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(color: Color(0xFFEEEEEE), height: 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.textDark,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '\$${order['total'].toStringAsFixed(2)}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _InfoRow(
          icon: Icons.location_on_rounded,
          title: 'Delivery Address',
          value: order['address'],
        ),
        const SizedBox(height: 10),
        _InfoRow(
          icon: Icons.payment_rounded,
          title: 'Payment Method',
          value: order['payment'],
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: AppColors.textDark,
    ),
  );
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
      ),
      Text(
        value,
        style: TextStyle(
          color: valueColor ?? AppColors.textDark,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: AppColors.primary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  color: AppColors.textGrey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
