import 'package:flutter/material.dart';
import 'package:freshpick/core/common/common_navigator.dart';

import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/product/presentation/screens/product_listing_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

class CommonRootScreen extends StatefulWidget {
  const CommonRootScreen({super.key});

  /// Switches the bottom navigation tab from any screen inside the root.
  static void switchTab(BuildContext context, int index) {
    context.findAncestorStateOfType<_CommonRootScreenState>()?._onTabTap(index);
  }

  @override
  State<CommonRootScreen> createState() => _CommonRootScreenState();
}

class _CommonRootScreenState extends State<CommonRootScreen> {
  int _currentIndex = NavIndex.home;

  void _onTabTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          ProductListingScreen(),
          CartScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CommonBottomNavigator(
        currentIndex: _currentIndex,
        onTap: _onTabTap,
      ),
    );
  }
}
