import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/common/common_button.dart';
import '../../../../core/common/common_loader.dart';
import '../../../../core/constants/app_colors.dart';
import 'order_details_section.dart';
import 'order_status_badge.dart';
import 'order_tracking_timeline.dart';

class OrderCard extends StatefulWidget {
  final Map<String, dynamic> order;
  final bool isActive;

  const OrderCard({super.key, required this.order, required this.isActive});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isExpanded = false;

  Map<String, dynamic> get order => widget.order;

  Future<void> _downloadInvoice() async {
    // TODO: generate and save the real invoice PDF once the API is ready.
    CommonLoader.show(context);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    CommonLoader.hide(context);
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
              Expanded(
                child: Text(
                  'Invoice_${order['id']}.pdf downloaded',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Image
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(order['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Order Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order['id'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppColors.textDark,
                              ),
                            ),
                            OrderStatusBadge(status: order['status']),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                order['date'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                            AnimatedRotation(
                              turns: _isExpanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 250),
                              child: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 20,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order['items'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${order['total'].toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AppColors.primary,
                              ),
                            ),
                            if (widget.isActive)
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.orderTracking,
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  "Track Order",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: AppColors.accent,
                                  ),
                                ),
                              )
                            else
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  "Reorder",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Expanded details
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: _isExpanded
                    ? _buildExpandedContent()
                    : const SizedBox(width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: Color(0xFFEEEEEE), height: 1),
          const SizedBox(height: 14),
          if (widget.isActive) ...[
            const Text(
              'Order Status',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            OrderTrackingTimeline(
              currentStep: order['trackingStep'] ?? 0,
              times: List<String>.from(order['trackingTimes'] ?? const []),
            ),
            const SizedBox(height: 14),
            const Divider(color: Color(0xFFEEEEEE), height: 1),
            const SizedBox(height: 14),
          ],
          OrderDetailsSection(order: order),
          if (!widget.isActive) ...[
            const SizedBox(height: 16),
            CommonButton(
              text: 'Download Invoice',
              icon: Icons.file_download_outlined,
              onPressed: _downloadInvoice,
              backgroundColor: AppColors.primary,
              outlined: true,
              borderWidth: 1.5,
              height: 46,
              fontSize: 14,
              iconSize: 20,
            ),
          ],
        ],
      ),
    );
  }
}
