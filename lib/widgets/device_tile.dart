import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimens.dart';
import '../core/constants/app_text_styles.dart';
import '../core/widgets/app_container.dart';
import '../models/device.dart';

/// A single row representing a nearby device, wrapped in an [AppContainer]
/// with a status dot, icon, and signal indicator.
class DeviceTile extends StatelessWidget {
  final DeviceModel device;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const DeviceTile({
    super.key,
    required this.device,
    this.onTap,
    this.onFavoriteTap,
  });

  IconData get _icon {
    switch (device.type) {
      case DeviceType.phone:
        return Icons.smartphone_rounded;
      case DeviceType.tablet:
        return Icons.tablet_mac_rounded;
      case DeviceType.laptop:
        return Icons.laptop_mac_rounded;
      case DeviceType.desktop:
        return Icons.desktop_windows_rounded;
      case DeviceType.unknown:
        return Icons.devices_other_rounded;
    }
  }

  Color get _statusColor {
    switch (device.status) {
      case DeviceStatus.available:
        return AppColors.success;
      case DeviceStatus.connecting:
        return AppColors.warning;
      case DeviceStatus.connected:
        return AppColors.info;
      case DeviceStatus.offline:
        return AppColors.textMuted;
    }
  }

  String get _statusLabel {
    switch (device.status) {
      case DeviceStatus.available:
        return 'Available';
      case DeviceStatus.connecting:
        return 'Connecting…';
      case DeviceStatus.connected:
        return 'Connected';
      case DeviceStatus.offline:
        return 'Offline';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = device.status == DeviceStatus.offline;

    return InkWell(
      onTap: isOffline ? null : onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
      child: Opacity(
        opacity: isOffline ? 0.5 : 1,
        child: AppContainer(
          margin: const EdgeInsets.only(bottom: AppDimens.space12),
          padding: const EdgeInsets.all(AppDimens.space16),
          child: Row(
            children: [
              Container(
                width: AppDimens.avatarSize,
                height: AppDimens.avatarSize,
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                ),
                child: Icon(_icon, color: AppColors.textPrimary, size: 22),
              ),
              const SizedBox(width: AppDimens.space16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.name,
                      style: AppTextStyles.bodyStrong,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppDimens.space4),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: AppDimens.space8),
                        Text(_statusLabel, style: AppTextStyles.caption),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppDimens.space12),
              if (!isOffline)
                Icon(
                  Icons.signal_cellular_alt_rounded,
                  color: AppColors.textMuted,
                  size: 18,
                ),
              const SizedBox(width: AppDimens.space12),
              InkWell(
                onTap: onFavoriteTap,
                borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.space4),
                  child: Icon(
                    device.isFavorite
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    color: device.isFavorite
                        ? AppColors.warning
                        : AppColors.textMuted,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
