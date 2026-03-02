import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/common/common_search_bar.dart';
import '../../../../core/common/common_view_toggle.dart';
import '../widgets/product_listing_view_widgets.dart';
import '../widgets/filter_bottomsheet.dart';
import '../widgets/video_background.dart';
import '../../../../core/constants/dummy_data.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  bool _isGridView = true;

  final List<Map<String, dynamic>> _products = DummyData.products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.34),
                CommonSearchBar(
                  onSearchBarTap: () =>
                      Navigator.pushNamed(context, AppRoutes.search),
                  rightIcon: Icons.filter_alt_outlined,
                  onRightIconTap: () => showFilterBottomSheet(context),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _isGridView
                      ? ProductListingGrid(items: _products)
                      : ProductListingList(items: _products),
                ),
              ],
            ),
          ),
          const VideoBackground(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonViewToggle(
                    isGridView: _isGridView,
                    onToggle: (v) => setState(() => _isGridView = v),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
