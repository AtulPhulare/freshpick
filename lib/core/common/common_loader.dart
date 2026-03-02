import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CommonLoader extends StatelessWidget {
  final double size;
  final Color color;

  const CommonLoader({
    super.key,
    this.size = 32.0,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(color: color, strokeWidth: 3),
      ),
    );
  }

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
