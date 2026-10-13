import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/common/common_header.dart';
import '../widgets/order_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CommonHeader(title: 'Your Orders'),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: AppColors.white,
                        unselectedLabelColor: AppColors.textGrey,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(21),
                        ),
                        labelStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        tabs: const [
                          Tab(text: "Active"),
                          Tab(text: "Past Orders"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [_buildActiveOrders(), _buildPastOrders()],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveOrders() {
    final activeOrders = [
      {
        'id': 'ORD-8291',
        'date': 'Oct 24, 2023',
        'status': 'In Transit',
        'items': 'Fuji Apple, Strawberry, Grapes',
        'image':
            'https://images.unsplash.com/photo-1619566636858-adf3ef46400c?w=400&q=80',
        'products': [
          {'name': 'Fuji Apple', 'qty': 2, 'price': 3.99},
          {'name': 'Strawberry', 'qty': 1, 'price': 6.99},
          {'name': 'Sweet Grapes', 'qty': 2, 'price': 5.49},
        ],
        'subtotal': 25.95,
        'deliveryFee': 2.00,
        'discount': 3.45,
        'total': 24.50,
        'address': '123 Fresh Street, Green Valley, NY 10001',
        'payment': 'Visa •••• 4242',
        'trackingStep': 2,
        'trackingTimes': ['12:05 PM', '12:30 PM', '01:15 PM', '02:00 PM'],
      },
      {
        'id': 'ORD-8292',
        'date': 'Oct 25, 2023',
        'status': 'Processing',
        'items': 'Avocado, Mango, Pineapple',
        'image':
            'https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?w=400&q=80',
        'products': [
          {'name': 'Avocado', 'qty': 3, 'price': 1.99},
          {'name': 'Mango', 'qty': 2, 'price': 2.49},
          {'name': 'Pineapple', 'qty': 1, 'price': 4.25},
        ],
        'subtotal': 15.20,
        'deliveryFee': 3.00,
        'discount': 0.00,
        'total': 18.20,
        'address': '456 Office Plaza, Business District, NY 10002',
        'payment': 'Cash on Delivery',
        'trackingStep': 1,
        'trackingTimes': ['09:40 AM', '10:05 AM', '--', '--'],
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: activeOrders.length,
      itemBuilder: (context, index) {
        return OrderCard(order: activeOrders[index], isActive: true);
      },
    );
  }

  Widget _buildPastOrders() {
    final pastOrders = [
      {
        'id': 'ORD-8101',
        'date': 'Oct 15, 2023',
        'status': 'Delivered',
        'items': 'Citrus Mix (Orange, Lime)',
        'image':
            'https://images.unsplash.com/photo-1557800636-894a64c1696f?w=400&q=80',
        'products': [
          {'name': 'Sweet Orange', 'qty': 4, 'price': 4.99},
          {'name': 'Lime', 'qty': 6, 'price': 2.49},
        ],
        'subtotal': 34.90,
        'deliveryFee': 0.00,
        'discount': 2.90,
        'total': 32.00,
        'address': '123 Fresh Street, Green Valley, NY 10001',
        'payment': 'Visa •••• 4242',
      },
      {
        'id': 'ORD-8055',
        'date': 'Oct 10, 2023',
        'status': 'Delivered',
        'items': 'Berry Delight (Blueberry, Raspberry)',
        'image':
            'https://images.unsplash.com/photo-1596387451750-f7bfb5146197?w=400&q=80',
        'products': [
          {'name': 'Blueberry', 'qty': 1, 'price': 5.20},
          {'name': 'Raspberry', 'qty': 1, 'price': 5.20},
        ],
        'subtotal': 10.40,
        'deliveryFee': 2.00,
        'discount': 0.00,
        'total': 12.40,
        'address': '456 Office Plaza, Business District, NY 10002',
        'payment': 'Apple Pay',
      },
      {
        'id': 'ORD-7998',
        'date': 'Oct 05, 2023',
        'status': 'Delivered',
        'items': 'Watermelon & Cantaloupe',
        'image':
            'https://images.unsplash.com/photo-1589927986089-35812388d1f4?w=400&q=80',
        'products': [
          {'name': 'Watermelon', 'qty': 1, 'price': 8.99},
          {'name': 'Cantaloupe', 'qty': 1, 'price': 5.51},
        ],
        'subtotal': 14.50,
        'deliveryFee': 1.00,
        'discount': 0.00,
        'total': 15.50,
        'address': '123 Fresh Street, Green Valley, NY 10001',
        'payment': 'Cash on Delivery',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pastOrders.length,
      itemBuilder: (context, index) {
        return OrderCard(order: pastOrders[index], isActive: false);
      },
    );
  }
}
