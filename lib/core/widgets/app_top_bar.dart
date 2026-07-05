import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_text_styles.dart';

/// A shared top bar used on inner screens (Nearby, Transfer, History,
/// Settings, etc.) with an optional leading back button and trailing
/// action icon. Kept as a plain widget (not a PreferredSizeWidget) so it
/// can be dropped into any layout, wrapped in its own Container.
class AppTopBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showBack;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;

  const AppTopBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = false,
    this.trailingIcon,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.appBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.space4),
      child: Row(
        children: [
          if (showBack) ...[
            _CircleIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: () => Navigator.of(context).maybePop(),
            ),
            const SizedBox(width: AppDimens.space12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTextStyles.h2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppDimens.space4),
                  Text(
                    subtitle!,
                    style: AppTextStyles.caption,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: AppDimens.space12),
            _CircleIconButton(icon: trailingIcon!, onTap: onTrailingTap),
          ],
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleIconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      child: Container(
        width: AppDimens.iconButtonSize,
        height: AppDimens.iconButtonSize,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.surfaceBorder),
        ),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}
