import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? backgroundColor;
  final Gradient? gradient;
  final bool showBorder;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.margin,
    this.borderRadius = 20,
    this.backgroundColor,
    this.gradient,
    this.showBorder = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    Widget card = ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: gradient,
            color: gradient == null
                ? (backgroundColor ??
                    (Theme.of(context).brightness == Brightness.dark
                        ? AppColors.bgGlass
                        : AppColors.bgGlassLight))
                : null,
            border: showBorder
                ? Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.bgGlassBorder
                        : AppColors.bgGlassBorderLight,
                    width: 1)
                : null,
          ),
          padding: padding,
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      card = GestureDetector(onTap: onTap, child: card);
    }

    if (margin != null) {
      card = Padding(padding: margin!, child: card);
    }

    return card;
  }
}

/// A solid card (no blur) — lighter weight for lists
class SolidCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Gradient? gradient;
  final VoidCallback? onTap;

  const SolidCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.margin,
    this.borderRadius = 16,
    this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);
    Widget card = Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: gradient ??
            (Theme.of(context).brightness == Brightness.dark
                ? AppColors.cardGradient
                : AppColors.cardGradientLight),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.bgGlassBorder
              : AppColors.bgGlassBorderLight,
          width: 0.5,
        ),
      ),
      padding: padding,
      child: child,
    );
    if (onTap != null) card = GestureDetector(onTap: onTap, child: card);
    if (margin != null) card = Padding(padding: margin!, child: card);
    return card;
  }
}
