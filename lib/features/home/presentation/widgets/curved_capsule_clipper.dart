import 'package:flutter/material.dart';

class CurvedCapsuleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    const curve = 6.0;

    path.moveTo(curve, 0);

    // Top curve
    path.quadraticBezierTo(
      size.width / 2,
      -curve,
      size.width - curve,
      0,
    );

    // Right side
    path.quadraticBezierTo(
      size.width,
      size.height / 2,
      size.width - curve,
      size.height,
    );

    // Bottom curve
    path.quadraticBezierTo(
      size.width / 2,
      size.height + curve,
      curve,
      size.height,
    );

    // Left side
    path.quadraticBezierTo(
      0,
      size.height / 2,
      curve,
      0,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
