import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimens.dart';
import '../models/file_metadata.dart';

/// Small colored square icon representing a file category, reused across
/// Transfer, Receive, and History screens.
class FileTypeIcon extends StatelessWidget {
  final FileCategory category;
  final double size;

  const FileTypeIcon({super.key, required this.category, this.size = 44});

  IconData get _icon {
    switch (category) {
      case FileCategory.image:
        return Icons.image_rounded;
      case FileCategory.video:
        return Icons.movie_rounded;
      case FileCategory.audio:
        return Icons.audiotrack_rounded;
      case FileCategory.document:
        return Icons.description_rounded;
      case FileCategory.archive:
        return Icons.folder_zip_rounded;
      case FileCategory.apk:
        return Icons.android_rounded;
      case FileCategory.folder:
        return Icons.folder_rounded;
      case FileCategory.other:
        return Icons.insert_drive_file_rounded;
    }
  }

  Color get _color {
    switch (category) {
      case FileCategory.image:
        return AppColors.info;
      case FileCategory.video:
        return AppColors.accentEnd;
      case FileCategory.audio:
        return AppColors.success;
      case FileCategory.document:
        return AppColors.accentStart;
      case FileCategory.archive:
        return AppColors.warning;
      case FileCategory.apk:
        return AppColors.success;
      case FileCategory.folder:
        return AppColors.textSecondary;
      case FileCategory.other:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
      ),
      child: Icon(_icon, color: _color, size: size * 0.5),
    );
  }
}
