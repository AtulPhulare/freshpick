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
        'total': 24.50,
        'image':
            'https://images.unsplash.com/photo-1619566636858-adf3ef46400c?w=400&q=80',
      },
      {
        'id': 'ORD-8292',
        'date': 'Oct 25, 2023',
        'status': 'Processing',
        'items': 'Avocado, Mango, Pineapple',
        'total': 18.20,
        'image':
            'https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?w=400&q=80',
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
        'total': 32.00,
        'image':
            'https://images.unsplash.com/photo-1557800636-894a64c1696f?w=400&q=80',
      },
      {
        'id': 'ORD-8055',
        'date': 'Oct 10, 2023',
        'status': 'Delivered',
        'items': 'Berry Delight (Blueberry, Raspberry)',
        'total': 12.40,
        'image':
            'https://images.unsplash.com/photo-1596387451750-f7bfb5146197?w=400&q=80',
      },
      {
        'id': 'ORD-7998',
        'date': 'Oct 05, 2023',
        'status': 'Delivered',
        'items': 'Watermelon & Cantaloupe',
        'total': 15.50,
        'image':
            'https://images.unsplash.com/photo-1589927986089-35812388d1f4?w=400&q=80',
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
