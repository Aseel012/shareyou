import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_text_styles.dart';

enum AppButtonVariant { primary, outline, ghost }

/// A pressable button with a subtle scale animation on tap-down/tap-up
/// so every primary action in the app feels tactile.
class AppButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final double? width;

  const AppButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.width,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
    lowerBound: 0.0,
    upperBound: 0.06,
  );

  void _onTapDown(TapDownDetails _) => _controller.forward();
  void _onTapUp(TapUpDetails _) => _controller.reverse();
  void _onTapCancel() => _controller.reverse();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.icon != null) ...[
          Icon(
            widget.icon,
            size: 20,
            color: widget.variant == AppButtonVariant.primary
                ? Colors.white
                : AppColors.textPrimary,
          ),
          const SizedBox(width: AppDimens.space8),
        ],
        Text(widget.label, style: AppTextStyles.button),
      ],
    );

    return GestureDetector(
      onTapDown: widget.onPressed == null ? null : _onTapDown,
      onTapUp: widget.onPressed == null ? null : _onTapUp,
      onTapCancel: widget.onPressed == null ? null : _onTapCancel,
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = 1 - _controller.value;
          return Transform.scale(scale: scale, child: child);
        },
        child: Container(
          width: widget.width,
          height: AppDimens.buttonHeight,
          alignment: Alignment.center,
          decoration: _decorationFor(widget.variant),
          child: content,
        ),
      ),
    );
  }

  BoxDecoration _decorationFor(AppButtonVariant variant) {
    switch (variant) {
      case AppButtonVariant.primary:
        return BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentStart.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        );
      case AppButtonVariant.outline:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          border: Border.all(color: AppColors.surfaceBorder, width: 1.2),
          color: AppColors.surface,
        );
      case AppButtonVariant.ghost:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          color: Colors.transparent,
        );
    }
  }
}
