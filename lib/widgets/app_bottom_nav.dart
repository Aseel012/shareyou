import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimens.dart';
import '../core/constants/app_text_styles.dart';

class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

const List<NavItem> kNavItems = [
  NavItem(
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    label: 'Home',
  ),
  NavItem(
    icon: Icons.wifi_tethering_outlined,
    activeIcon: Icons.wifi_tethering_rounded,
    label: 'Nearby',
  ),
  NavItem(
    icon: Icons.history_outlined,
    activeIcon: Icons.history_rounded,
    label: 'History',
  ),
  NavItem(
    icon: Icons.settings_outlined,
    activeIcon: Icons.settings_rounded,
    label: 'Settings',
  ),
];

/// Custom bottom navigation bar with an animated pill indicator that
/// slides beneath the selected icon.
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.bottomNavHeight,
      margin: const EdgeInsets.fromLTRB(
        AppDimens.space16,
        0,
        AppDimens.space16,
        AppDimens.space16,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.space8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
        border: Border.all(color: AppColors.surfaceBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: List.generate(kNavItems.length, (index) {
          final isSelected = index == currentIndex;
          final item = kNavItems[index];
          return Expanded(
            child: InkWell(
              onTap: () => onTap(index),
              borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                margin: const EdgeInsets.symmetric(vertical: AppDimens.space8),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.space8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.accentStart.withOpacity(0.14)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isSelected ? item.activeIcon : item.icon,
                      color: isSelected
                          ? AppColors.accentStart
                          : AppColors.textMuted,
                      size: 22,
                    ),
                    const SizedBox(height: AppDimens.space4),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: AppTextStyles.caption.copyWith(
                        color: isSelected
                            ? AppColors.accentStart
                            : AppColors.textMuted,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                      child: Text(item.label),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
