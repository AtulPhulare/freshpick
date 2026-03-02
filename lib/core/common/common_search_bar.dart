import 'package:flutter/material.dart';
import 'package:freshpick/core/common/common_icon_button.dart';
import '../constants/app_colors.dart';

class CommonSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onSearchBarTap;
  final Color? searchBarBackgroundColor;
  final Color? searchBarBorderColor;
  final double? searchBarHeight;
  final double? searchBarBorderRadius;

  final IconData leftIcon;
  final Color? leftIconColor;
  final double? leftIconSize;
  final VoidCallback? onLeftIconTap;

  final IconData rightIcon;
  final Color? rightIconColor;
  final double? rightIconSize;
  final VoidCallback? onRightIconTap;
  final Color? rightIconBackgroundColor;
  final Color? rightIconBorderColor;
  final double? rightIconSizeContainer;

  final int badgeCount;
  final bool showBadge;
  final Color? badgeColor;
  final Color? badgeBorderColor;
  final double? badgeBorderWidth;

  final TextStyle? hintTextStyle;

  const CommonSearchBar({
    super.key,
    this.hintText = 'Search for "Grocery"',
    this.onSearchBarTap,
    this.searchBarBackgroundColor,
    this.searchBarBorderColor,
    this.searchBarHeight,
    this.searchBarBorderRadius,
    this.leftIcon = Icons.search_rounded,
    this.leftIconColor,
    this.leftIconSize,
    this.onLeftIconTap,
    this.rightIcon = Icons.shopping_cart_outlined,
    this.rightIconColor,
    this.rightIconSize,
    this.onRightIconTap,
    this.rightIconBackgroundColor,
    this.rightIconBorderColor,
    this.rightIconSizeContainer,
    this.badgeCount = 0,
    this.showBadge = true,
    this.badgeColor,
    this.badgeBorderColor,
    this.badgeBorderWidth,
    this.hintTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onSearchBarTap,
            child: Container(
              height: searchBarHeight ?? 50,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: searchBarBackgroundColor ?? AppColors.white,
                borderRadius: BorderRadius.circular(
                  searchBarBorderRadius ?? 15,
                ),
                border: Border.all(
                  color:
                      searchBarBorderColor ??
                      AppColors.primary.withValues(alpha: 0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.04),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onLeftIconTap ?? onSearchBarTap,
                    child: Icon(
                      leftIcon,
                      color: leftIconColor ?? AppColors.primary,
                      size: leftIconSize ?? 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      hintText,
                      style:
                          hintTextStyle ??
                          TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.textGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.2,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        CommonIconButton(
          icon: rightIcon,
          onTap: onRightIconTap,
          size: rightIconSizeContainer ?? 50,
          iconSize: rightIconSize ?? 22,
          backgroundColor: rightIconBackgroundColor ?? AppColors.primary,
          iconColor: rightIconColor ?? AppColors.white,
          borderColor:
              rightIconBorderColor ?? AppColors.primary.withValues(alpha: 0.1),
          showBadge: showBadge,
          badgeCount: badgeCount,
          badgeColor: badgeColor ?? AppColors.accent,
          badgeBorderColor: badgeBorderColor ?? AppColors.white,
          badgeBorderWidth: badgeBorderWidth ?? 1.5,
          borderRadius: searchBarBorderRadius ?? 15,
        ),
      ],
    );
  }
}
