/// Centralized spacing, radius, and sizing constants.
/// Keeping every magic number in one place makes the UI easy to retune.
class AppDimens {
  AppDimens._();

  // Spacing scale
  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space20 = 20;
  static const double space24 = 24;
  static const double space32 = 32;
  static const double space40 = 40;
  static const double space48 = 48;
  static const double space80 = 80;

  // Radius scale
  static const double radiusSmall = 10;
  static const double radiusMedium = 16;
  static const double radiusLarge = 24;
  static const double radiusPill = 100;

  // Component sizing
  static const double buttonHeight = 54;
  static const double iconButtonSize = 46;
  static const double bottomNavHeight = 72;
  static const double appBarHeight = 64;
  static const double avatarSize = 48;

  // Breakpoints for responsive layout
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1024;
}
