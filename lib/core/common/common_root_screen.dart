import 'package:flutter/material.dart';
import 'package:freshpick/core/common/common_navigator.dart';

import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/product/presentation/screens/product_listing_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

class CommonRootScreen extends StatefulWidget {
  const CommonRootScreen({super.key});

  @override
  State<CommonRootScreen> createState() => _CommonRootScreenState();
}

class _CommonRootScreenState extends State<CommonRootScreen> {
  int _currentIndex = NavIndex.home;

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
        onTap: (index) {
          if (index == _currentIndex) return;
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
