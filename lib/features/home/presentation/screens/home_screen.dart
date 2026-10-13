import 'package:flutter/material.dart';
import 'package:freshpick/core/common/common_chip.dart';
import 'package:freshpick/core/common/common_navigator.dart';
import 'package:freshpick/core/common/common_product_card_vertical.dart';
import 'package:freshpick/core/common/common_root_screen.dart';
import 'package:freshpick/core/constants/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/common/common_animated_section.dart';
import '../../../../core/common/common_section_header.dart';
import '../widgets/category_delivery_card.dart';
import '../widgets/curved_category_carousel_advanced.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/common/common_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;

  static const List<Map<String, dynamic>> _products = [
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=300&q=80',
      'name': 'Fresh Apple',
      'weight': '1 kg',
      'price': 17.99,
      'originalPrice': 20.99,
      'rating': 4.8,
      'reviewCount': 214,
      'isOrganic': true,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=300&q=80',
      'name': 'Banana',
      'weight': '500 gm',
      'price': 9.99,
      'originalPrice': 12.99,
      'rating': 4.3,
      'reviewCount': 98,
      'isOrganic': false,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1580052614034-c55d20bfee3b?w=300&q=80',
      'name': 'Sweet Orange',
      'weight': '1 kg',
      'price': 14.99,
      'originalPrice': 18.99,
      'rating': 4.5,
      'reviewCount': 176,
      'isOrganic': true,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1587393855524-087f83d95bc9?w=300&q=80',
      'name': 'Strawberry',
      'weight': '250 gm',
      'price': 22.99,
      'originalPrice': 26.99,
      'rating': 4.9,
      'reviewCount': 341,
      'isOrganic': true,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1563114773-84221bd62daa?w=300&q=80',
      'name': 'Watermelon',
      'weight': '1 pc',
      'price': 27.99,
      'originalPrice': 32.99,
      'rating': 4.6,
      'reviewCount': 89,
      'isOrganic': false,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=300&q=80',
      'name': 'Sweet Grapes',
      'weight': '500 gm',
      'price': 19.99,
      'originalPrice': 23.99,
      'rating': 4.4,
      'reviewCount': 132,
      'isOrganic': false,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=300&q=80',
      'name': 'Mango',
      'weight': '1 kg',
      'price': 24.99,
      'originalPrice': 29.99,
      'rating': 4.7,
      'reviewCount': 267,
      'isOrganic': true,
    },
  ];

  final List<CategoryItem> categories = [
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1580052614034-c55d20bfee3b?w=200&q=80',
      label: 'Orange',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=200&q=80',
      label: 'Strawberry',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=200&q=80',
      label: 'Watermelon',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=200&q=80',
      label: 'Banana',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=200&q=80',
      label: 'Fresh Apple',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=200&q=80',
      label: 'Mango',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=200&q=80',
      label: 'Grapes',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1603833665858-e61d17a86224?w=200&q=80',
      label: 'Kiwi',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1589927986089-35812388d1f4?w=200&q=80',
      label: 'Lemon',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=200&q=80',
      label: 'Potato',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1629421377714-3b4fcf4fd97d?w=200&q=80',
      label: 'Blueberry',
    ),
    CategoryItem(
      imageUrl:
          'https://images.unsplash.com/photo-1563114773-84221bd62daa?w=200&q=80',
      label: 'Pineapple',
    ),
  ];

  final List<Map<String, dynamic>> shopLocations = [
    {
      'name': 'Fresh Produce Market',
      'type': 'Grocery',
      'position': const LatLng(28.6139, 77.2090),
      'emoji': '🛒',
    },
    {
      'name': 'Green Valley Store',
      'type': 'Organic',
      'position': const LatLng(28.6189, 77.2150),
      'emoji': '🥬',
    },
    {
      'name': 'Daily Needs Shop',
      'type': 'Grocery',
      'position': const LatLng(28.6089, 77.2140),
      'emoji': '🏪',
    },
    {
      'name': 'Farm Fresh Corner',
      'type': 'Vegetables',
      'position': const LatLng(28.6159, 77.2050),
      'emoji': '🥕',
    },
    {
      'name': 'Wholesale Hub',
      'type': 'Wholesale',
      'position': const LatLng(28.6119, 77.2110),
      'emoji': '🏬',
    },
    {
      'name': 'Quick Mart',
      'type': 'Convenience',
      'position': const LatLng(28.6169, 77.2100),
      'emoji': '🛍️',
    },
    {
      'name': 'Local Bazaar',
      'type': 'Market',
      'position': const LatLng(28.6099, 77.2070),
      'emoji': '🏪',
    },
  ];

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  void _createMarkers() {
    _markers = shopLocations.map((shop) {
      return Marker(
        markerId: MarkerId(shop['name']),
        position: shop['position'],
        infoWindow: InfoWindow(title: shop['name'], snippet: shop['type']),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      );
    }).toSet();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 380),
              Expanded(
                child: ClipRect(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonAnimatedSection(
                            index: 0,
                            child: CommonSectionHeader(
                              title: 'Nearby Shops',
                              actionText: 'View all',
                              onActionTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.shopListing,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Map container with elevation and modern styling
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 320,
                                    child: GoogleMap(
                                      onMapCreated: _onMapCreated,
                                      initialCameraPosition:
                                          const CameraPosition(
                                            target: LatLng(28.6139, 77.2090),
                                            zoom: 13.5,
                                          ),
                                      markers: _markers,
                                      myLocationButtonEnabled: false,
                                      zoomControlsEnabled: false,
                                      mapType: MapType.normal,
                                    ),
                                  ),
                                  // Floating info badge
                                  Positioned(
                                    bottom: 12,
                                    left: 12,
                                    child: CommonChip(
                                      icon: Icons.house_outlined,
                                      label: '7 Nearby Shops',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),
                          CommonAnimatedSection(
                            index: 1,
                            child: Column(
                              children: [
                                CommonSectionHeader(
                                  title: 'You might need',
                                  actionText: 'See more',
                                  onActionTap: () => CommonRootScreen.switchTab(
                                    context,
                                    NavIndex.list,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _products.length,
                                    itemBuilder: (context, index) {
                                      final item = _products[index];

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 16,
                                        ),
                                        child: SizedBox(
                                          width: 160,
                                          child: CommonProductCardVertical(
                                            imageUrl: item['imageUrl'],
                                            title: item['name'],
                                            tag: item['isOrganic']
                                                ? 'Organic'
                                                : 'Fresh',
                                            rating: item['rating'],
                                            reviews: item['reviewCount'],
                                            price: item['price'],
                                            originalPrice: item['price'] + 3,
                                            discountPercent: 15,
                                            onAddToCart: () {},
                                            onFavorite: () {},
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Delivery Options
                          CommonAnimatedSection(
                            index: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CategoryDeliveryCard(
                                    emoji: '🛒',
                                    title: 'Grocery',
                                    timeText: 'By 12:15pm',
                                    deliveryText: 'Free Delivery',
                                    backgroundColor: const Color(0xFFE8F5E9),
                                    deliveryColor: const Color(0xFF4CAF50),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: CategoryDeliveryCard(
                                    emoji: '🥑',
                                    title: 'Wholesale Items With Long Name',
                                    timeText: 'By 1:30pm',
                                    deliveryText: 'Free Delivery',
                                    backgroundColor: const Color(0xFFFCE4EC),
                                    deliveryColor: Colors.pink,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          CurvedCategoryCarouselAdvanced(categories: categories),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 40,
                    ), // Placeholder for potential left icon
                    // CommonChip(label: 'California, USA'),
                  ],
                ),
                const SizedBox(height: 16),
                CommonSearchBar(
                  onSearchBarTap: () =>
                      Navigator.pushNamed(context, AppRoutes.search),
                  hintText: 'Search for "Fruits"',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
