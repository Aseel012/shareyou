import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimens.dart';
import '../core/constants/app_text_styles.dart';
import '../core/widgets/app_container.dart';

/// Small stat card used on the Home dashboard, e.g. "Files Sent: 128".
class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color accentColor;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.accentColor = AppColors.accentStart,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.all(AppDimens.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.14),
              borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
            ),
            child: Icon(icon, color: accentColor, size: 18),
          ),
          const SizedBox(height: AppDimens.space12),
          Text(value, style: AppTextStyles.statNumber),
          const SizedBox(height: AppDimens.space4),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
