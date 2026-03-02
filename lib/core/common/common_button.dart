import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double borderRadius;
  final FontWeight fontWeight;
  final double fontSize;
  final IconData? icon;
  final String? svgIcon;
  final double iconSize;
  final Color? iconColor;
  final double iconSpacing;

  final bool outlined;
  final double? borderWidth;
  final double letterSpacing;
  final EdgeInsets? padding;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
    this.height = 54,
    this.borderRadius = 16,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 16,
    this.icon,
    this.svgIcon,
    this.iconSize = 22,
    this.iconColor,
    this.iconSpacing = 10,
    this.outlined = false,
    this.borderWidth,
    this.letterSpacing = 0.3,
    this.padding,
  });

  bool get _isDisabled => onPressed == null;

  bool get _hasIcon => icon != null || svgIcon != null;

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor = outlined
        ? (_isDisabled
              ? backgroundColor.withValues(alpha: 0.4)
              : backgroundColor)
        : (_isDisabled ? textColor.withValues(alpha: 0.5) : textColor);

    final Color effectiveIconColor = iconColor ?? effectiveTextColor;

    final Color effectiveBackgroundColor = outlined
        ? Colors.transparent
        : (_isDisabled
              ? backgroundColor.withValues(alpha: 0.4)
              : backgroundColor);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      elevation: _isDisabled || outlined ? 0 : 3,
      shadowColor: backgroundColor.withValues(alpha: 0.25),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: outlined
                ? Border.all(
                    color: _isDisabled
                        ? backgroundColor.withValues(alpha: 0.3)
                        : backgroundColor,
                    width: borderWidth ?? 2,
                  )
                : null,
          ),
          child: Container(
            width: double.infinity,
            height: height,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.center,
            child: _hasIcon
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIcon(effectiveIconColor),
                      SizedBox(width: iconSpacing),
                      Flexible(child: _buildText(effectiveTextColor)),
                    ],
                  )
                : _buildText(effectiveTextColor),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(Color effectiveTextColor) {
    // SVG gets priority
    if (svgIcon != null) {
      return SvgPicture.asset(
        svgIcon!,
        height: iconSize,
        width: iconSize,
        // Only apply color if iconColor is provided
        colorFilter: iconColor != null
            ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
            : null,
      );
    }

    if (icon != null) {
      return Icon(
        icon,
        size: iconSize,
        // If iconColor is null → fallback to effectiveTextColor
        color: iconColor ?? effectiveTextColor,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildText(Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        fontFamily: 'Poppins',
        height: 1.2,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? svgIcon;
  final Color? iconColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.svgIcon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      svgIcon: svgIcon,
      iconColor: iconColor,
      backgroundColor: AppColors.primary,
      textColor: Colors.white,
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? svgIcon;
  final FontWeight fontWeight;
  final Color? iconColor;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.svgIcon,
    this.iconColor,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      svgIcon: svgIcon,
      iconColor: iconColor,
      fontWeight: fontWeight,
      backgroundColor: AppColors.primary,
      textColor: AppColors.primary,
      outlined: true,
    );
  }
}
