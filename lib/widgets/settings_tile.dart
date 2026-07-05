import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimens.dart';
import '../core/constants/app_text_styles.dart';

/// A single settings row. Supports either a trailing switch or a trailing
/// chevron (for navigation-style rows). Each row is wrapped by the parent
/// screen inside an [AppContainer] "section" — this widget is the row
/// content only, separated with SizedBox/Divider by the parent list.
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final bool showChevron;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.switchValue,
    this.onSwitchChanged,
    this.showChevron = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.space12),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
              ),
              child: Icon(icon, size: 18, color: AppColors.textPrimary),
            ),
            const SizedBox(width: AppDimens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bodyStrong),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppDimens.space4),
                    Text(subtitle!, style: AppTextStyles.caption),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppDimens.space12),
            if (switchValue != null)
              Switch(value: switchValue!, onChanged: onSwitchChanged)
            else if (showChevron)
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
              ),
          ],
        ),
      ),
    );
  }
}
