import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimens.dart';
import '../core/constants/app_text_styles.dart';
import '../core/widgets/app_container.dart';
import '../models/transfer.dart';
import 'file_type_icon.dart';

/// Card shown on the Transfer screen for each active/queued transfer.
/// Includes an animated progress bar — purely visual for Phase 1.
class TransferProgressCard extends StatelessWidget {
  final TransferModel transfer;

  const TransferProgressCard({super.key, required this.transfer});

  String get _stateLabel {
    switch (transfer.state) {
      case TransferState.queued:
        return 'Queued';
      case TransferState.inProgress:
        return 'Transferring';
      case TransferState.paused:
        return 'Paused';
      case TransferState.completed:
        return 'Completed';
      case TransferState.failed:
        return 'Failed';
    }
  }

  Color get _stateColor {
    switch (transfer.state) {
      case TransferState.queued:
        return AppColors.textMuted;
      case TransferState.inProgress:
        return AppColors.info;
      case TransferState.paused:
        return AppColors.warning;
      case TransferState.completed:
        return AppColors.success;
      case TransferState.failed:
        return AppColors.error;
    }
  }

  String _formatEta(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    if (m == 0 && s == 0) return '--';
    return '${m}m ${s}s left';
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      margin: const EdgeInsets.only(bottom: AppDimens.space12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FileTypeIcon(category: transfer.file.category),
              const SizedBox(width: AppDimens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transfer.file.fileName,
                      style: AppTextStyles.bodyStrong,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppDimens.space4),
                    Text(
                      'to ${transfer.deviceName} · ${transfer.file.formattedSize}',
                      style: AppTextStyles.caption,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.space12,
                  vertical: AppDimens.space4,
                ),
                decoration: BoxDecoration(
                  color: _stateColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                ),
                child: Text(
                  _stateLabel,
                  style: AppTextStyles.caption.copyWith(
                    color: _stateColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.space16),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: transfer.progress),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: AppColors.surfaceElevated,
                  valueColor: AlwaysStoppedAnimation(
                    transfer.state == TransferState.failed
                        ? AppColors.error
                        : AppColors.accentStart,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppDimens.space8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(transfer.progress * 100).toStringAsFixed(0)}%',
                style: AppTextStyles.caption,
              ),
              if (transfer.state == TransferState.inProgress) ...[
                Text(
                  '${transfer.speedMBps.toStringAsFixed(1)} MB/s · ${_formatEta(transfer.eta)}',
                  style: AppTextStyles.caption,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
