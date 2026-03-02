import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isFilled;
  final bool isFocused;
  final int index;
  final Function(int, String) onChanged;
  final Function(int, RawKeyEvent) onKeyPressed;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isFilled,
    required this.isFocused,
    required this.index,
    required this.onChanged,
    required this.onKeyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 56,
      margin: EdgeInsets.only(
        right: index < 5 ? 8 : 0,
        left: index == 3 ? 8 : 0,
      ),
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) => onKeyPressed(index, event),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isFilled ? AppColors.primaryLight : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isFocused
                  ? AppColors.primary
                  : isFilled
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : AppColors.textGrey.withValues(alpha: 0.25),
              width: isFocused ? 2 : 1.5,
            ),
            boxShadow: isFocused
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (value) => onChanged(index, value),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ),
    );
  }
}
