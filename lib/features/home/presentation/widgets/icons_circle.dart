import 'package:flutter/material.dart';
import 'package:freshpick/core/constants/app_colors.dart';

class IconInCircle extends StatefulWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final bool showBorder;
  final bool showShadow;
  final double? elevation;
  final bool enableRipple;

  const IconInCircle({
    super.key,
    required this.icon,
    this.size = 44,
    this.iconSize = 22,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.showBorder = false,
    this.showShadow = true,
    this.elevation,
    this.enableRipple = true,
  });

  @override
  State<IconInCircle> createState() => _IconInCircleState();
}

class _IconInCircleState extends State<IconInCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = widget.backgroundColor ?? Colors.white;
    final effectiveIconColor = widget.iconColor ?? AppColors.textDark;
    final effectiveBorderColor = widget.borderColor ?? AppColors.primary.withValues(alpha:0.15);

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            shape: BoxShape.circle,
            border: widget.showBorder
                ? Border.all(
                    color: effectiveBorderColor,
                    width: 1.5,
                  )
                : null,
            boxShadow: widget.showShadow
                ? [
                    BoxShadow(
                      color: _isPressed
                          ? Colors.black.withValues(alpha:0.08)
                          : Colors.black.withValues(alpha:0.12),
                      blurRadius: _isPressed ? 8 : 12,
                      offset: _isPressed ? const Offset(0, 2) : const Offset(0, 4),
                      spreadRadius: 0,
                    ),
                    if (widget.elevation != null && widget.elevation! > 0)
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha:0.1),
                        blurRadius: widget.elevation! * 2,
                        offset: Offset(0, widget.elevation!),
                        spreadRadius: 0,
                      ),
                  ]
                : null,
          ),
          child: widget.enableRipple && widget.onTap != null
              ? Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {}, // Handled by GestureDetector
                    borderRadius: BorderRadius.circular(widget.size / 2),
                    splashColor: AppColors.primary.withValues(alpha:0.1),
                    highlightColor: AppColors.primary.withValues(alpha:0.05),
                    child: Center(
                      child: Icon(
                        widget.icon,
                        size: widget.iconSize,
                        color: effectiveIconColor,
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Icon(
                    widget.icon,
                    size: widget.iconSize,
                    color: effectiveIconColor,
                  ),
                ),
        ),
      ),
    );
  }
}

// Preset Variants for common use cases
class PrimaryIconInCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;

  const PrimaryIconInCircle({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 44,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return IconInCircle(
      icon: icon,
      onTap: onTap,
      size: size,
      iconSize: iconSize,
      backgroundColor: AppColors.primary,
      iconColor: Colors.white,
      showBorder: false,
      elevation: 4,
    );
  }
}

class OutlinedIconInCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;

  const OutlinedIconInCircle({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 44,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return IconInCircle(
      icon: icon,
      onTap: onTap,
      size: size,
      iconSize: iconSize,
      backgroundColor: Colors.white,
      iconColor: AppColors.primary,
      borderColor: AppColors.primary,
      showBorder: true,
      showShadow: false,
    );
  }
}

class GhostIconInCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;

  const GhostIconInCircle({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 44,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return IconInCircle(
      icon: icon,
      onTap: onTap,
      size: size,
      iconSize: iconSize,
      backgroundColor: AppColors.primaryLight,
      iconColor: AppColors.primary,
      showBorder: false,
      showShadow: false,
    );
  }
}