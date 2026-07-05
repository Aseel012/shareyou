import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimens.dart';
import '../core/constants/app_text_styles.dart';
import '../core/widgets/app_container.dart';
import '../models/history.dart';
import 'file_type_icon.dart';

/// A single row in the History screen list, wrapped in an [AppContainer].
class HistoryTile extends StatelessWidget {
  final HistoryModel item;

  const HistoryTile({super.key, required this.item});

  IconData get _directionIcon => item.direction == HistoryDirection.sent
      ? Icons.north_east_rounded
      : Icons.south_west_rounded;

  Color get _resultColor {
    switch (item.result) {
      case HistoryResult.success:
        return AppColors.success;
      case HistoryResult.failed:
        return AppColors.error;
      case HistoryResult.cancelled:
        return AppColors.textMuted;
    }
  }

  String get _resultLabel {
    switch (item.result) {
      case HistoryResult.success:
        return 'Success';
      case HistoryResult.failed:
        return 'Failed';
      case HistoryResult.cancelled:
        return 'Cancelled';
    }
  }

  String _formatTime(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      margin: const EdgeInsets.only(bottom: AppDimens.space12),
      child: Row(
        children: [
          FileTypeIcon(category: item.file.category),
          const SizedBox(width: AppDimens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.file.fileName,
                  style: AppTextStyles.bodyStrong,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimens.space4),
                Row(
                  children: [
                    Icon(_directionIcon, size: 13, color: AppColors.textMuted),
                    const SizedBox(width: AppDimens.space4),
                    Flexible(
                      child: Text(
                        '${item.deviceName} · ${item.file.formattedSize}',
                        style: AppTextStyles.caption,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimens.space12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _resultLabel,
                style: AppTextStyles.caption.copyWith(
                  color: _resultColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppDimens.space4),
              Text(_formatTime(item.timestamp), style: AppTextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }
}
