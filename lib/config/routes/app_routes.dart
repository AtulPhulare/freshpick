import 'package:flutter/material.dart';
import '../../features/user/presentation/screens/phone_login_screen.dart';
import '../../features/user/presentation/screens/otp_verification_screen.dart';
import '../../features/user/presentation/screens/address_screen.dart';
import '../../features/product/presentation/screens/product_detail_page.dart';
import '../../features/cart/presentation/screens/order_reciept_screen.dart';
import '../../features/wishlist/presentation/screens/wishlist_screen.dart';
import '../../features/orders/presentation/screens/orders_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/saved_address_screen.dart';
import '../../features/profile/presentation/screens/payment_methods_screen.dart';
import '../../core/common/common_root_screen.dart';
import 'package:freshpick/features/product/presentation/screens/product_listing_screen.dart';
import 'package:freshpick/features/product/presentation/screens/search_screen.dart';
import 'package:freshpick/features/user/presentation/screens/onboarding_screen.dart';
import 'package:freshpick/features/orders/presentation/screens/order_tracking_screen.dart';
import 'package:freshpick/features/shop/presentation/screens/shop_listing_screen.dart';
import 'route_transitions.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String search = '/search';
  static const String productListing = '/product-listing';
  static const String phoneLogin = '/phone-login';
  static const String otpVerification = '/otp-verification';
  static const String address = '/address';
  static const String home = '/home';
  static const String productDetail = '/product-detail';
  static const String orderReceipt = '/order-receipt';
  static const String wishlist = '/wishlist';
  static const String orders = '/orders';
  static const String editProfile = '/edit-profile';
  static const String savedAddress = '/saved-address';
  static const String paymentMethods = '/payment-methods';
  static const String orderTracking = '/order-tracking';
  static const String shopListing = '/shop-listing';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return RouteTransition.build(
          const OnboardingScreen(),
          animation: RouteAnimation.fade,
        );
      case search:
        return RouteTransition.build(
          const SearchScreen(),
          animation: RouteAnimation.fade,
        );
      case productListing:
        return RouteTransition.build(
          const ProductListingScreen(),
          animation: RouteAnimation.slide,
        );
      case phoneLogin:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const PhoneLoginScreen(),
        );

      case otpVerification:
        final phoneNumber = settings.arguments as String? ?? '';
        return RouteTransition.build(
          OtpVerificationScreen(phoneNumber: phoneNumber),
          animation: RouteAnimation.fade,
        );

      case address:
        return RouteTransition.build(
          const AddressScreen(),
          animation: RouteAnimation.fade,
        );

      case home:
        return RouteTransition.build(
          const CommonRootScreen(),
          animation: RouteAnimation.fade,
        );

      case productDetail:
        final imageUrl = settings.arguments as String?;
        return RouteTransition.build(
          ProductDetailsPage(imageUrl: imageUrl),
          animation: RouteAnimation.slide,
        );

      case orderReceipt:
        final args = settings.arguments as Map<String, double>? ?? {};
        return RouteTransition.build(
          OrderRecieptScreen(
            subtotal: args['subtotal'] ?? 0,
            deliveryFee: args['deliveryFee'] ?? 0,
            discount: args['discount'] ?? 0,
            total: args['total'] ?? 0,
          ),
          animation: RouteAnimation.fade,
        );

      case wishlist:
        return RouteTransition.build(
          const WishlistScreen(),
          animation: RouteAnimation.slide,
        );

      case orders:
        return RouteTransition.build(
          const OrdersScreen(),
          animation: RouteAnimation.slide,
        );
      case editProfile:
        return RouteTransition.build(
          const EditProfileScreen(),
          animation: RouteAnimation.slide,
        );
      case savedAddress:
        return RouteTransition.build(
          const SavedAddressScreen(),
          animation: RouteAnimation.slide,
        );
      case paymentMethods:
        return RouteTransition.build(
          const PaymentMethodsScreen(),
          animation: RouteAnimation.slide,
        );
      case orderTracking:
        return RouteTransition.build(
          const OrderTrackingScreen(),
          animation: RouteAnimation.slide,
        );
      case shopListing:
        return RouteTransition.build(
          const ShopListingScreen(),
          animation: RouteAnimation.slide,
        );

      default:
        return RouteTransition.build(
          const PhoneLoginScreen(),
          animation: RouteAnimation.fade,
        );
    }
  }
}
