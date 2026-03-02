import 'package:flutter/material.dart';

enum RouteAnimation { fade, slide, scale }

class RouteTransition {
  static Route build(
    Widget page, {
    RouteAnimation animation = RouteAnimation.fade,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, anim, __, child) {
        switch (animation) {
          case RouteAnimation.slide:
            return SlideTransition(
              position: anim.drive(
                Tween(begin: const Offset(1, 0), end: Offset.zero),
              ),
              child: child,
            );
          case RouteAnimation.scale:
            return ScaleTransition(scale: anim, child: child);
          case RouteAnimation.fade:
          return FadeTransition(opacity: anim, child: child);
        }
      },
    );
  }
}
