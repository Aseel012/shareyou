import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

/// A single reusable "card" container used everywhere in the app so every
/// screen has the same rounded surface, border, and soft shadow language.
///
/// Every piece of UI content in SwiftShare AI should be wrapped with this
/// widget (or a plain [Container] + [SizedBox] combo) instead of ad-hoc
/// styling, so the app stays visually consistent as new screens are added.
class AppContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Gradient? gradient;
  final Color? color;
  final double borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;

  const AppContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppDimens.space16),
    this.margin,
    this.gradient,
    this.color,
    this.borderRadius = AppDimens.radiusMedium,
    this.border,
    this.boxShadow,
    this.width,
    this.height,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        color: gradient == null ? (color ?? AppColors.surface) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ??
            Border.all(color: AppColors.surfaceBorder, width: 1),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: AppColors.shadow.withOpacity(0.25),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
      ),
      child: child,
    );
  }
}
