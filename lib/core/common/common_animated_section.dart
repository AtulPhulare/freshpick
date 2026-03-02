import 'package:flutter/material.dart';

class CommonAnimatedSection extends StatelessWidget {
  final int index;
  final Widget child;
  final Duration? duration;
  final double offset;

  const CommonAnimatedSection({
    super.key,
    required this.index,
    required this.child,
    this.duration,
    this.offset = 30,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration ?? Duration(milliseconds: 600 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, offset * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
