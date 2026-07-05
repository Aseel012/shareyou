import 'package:flutter/material.dart';
import '../constants/app_dimens.dart';

/// Lightweight responsive helper used across all screens so the UI
/// scales cleanly between phones, foldables, and tablets.
class Responsive {
  final BuildContext context;
  late final Size _size;

  Responsive(this.context) {
    _size = MediaQuery.of(context).size;
  }

  double get width => _size.width;
  double get height => _size.height;

  bool get isMobile => width < AppDimens.mobileMaxWidth;
  bool get isTablet =>
      width >= AppDimens.mobileMaxWidth && width < AppDimens.tabletMaxWidth;
  bool get isDesktop => width >= AppDimens.tabletMaxWidth;

  /// Scales a base size relative to a 390-logical-pixel design reference
  /// width (a common phone width) so paddings/fonts feel proportional
  /// on larger screens without ever shrinking below the base value.
  double scale(double base) {
    final factor = width / 390.0;
    final clamped = factor.clamp(0.9, 1.4);
    return base * clamped;
  }

  /// Returns the number of grid columns appropriate for the current width.
  int gridColumns() {
    if (isDesktop) return 4;
    if (isTablet) return 3;
    return 2;
  }

  /// Horizontal page padding that grows gently on wider screens.
  double get pagePadding {
    if (isDesktop) return AppDimens.space48;
    if (isTablet) return AppDimens.space32;
    return AppDimens.space20;
  }

  /// Caps content width on very wide screens so text/cards
  /// don't stretch edge to edge on tablets/desktop.
  double get maxContentWidth => isDesktop ? 720 : double.infinity;
}

extension ResponsiveContext on BuildContext {
  Responsive get responsive => Responsive(this);
}
