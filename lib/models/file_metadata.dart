/// Describes a single file selected/queued for transfer.
/// Phase 1: pure data holder used to drive placeholder UI lists.
enum FileCategory { image, video, audio, document, archive, apk, folder, other }

class FileMetadataModel {
  final String id;
  final String fileName;
  final int sizeInBytes;
  final FileCategory category;
  final String? thumbnailPath;

  const FileMetadataModel({
    required this.id,
    required this.fileName,
    required this.sizeInBytes,
    this.category = FileCategory.other,
    this.thumbnailPath,
  });

  String get formattedSize {
    if (sizeInBytes >= 1073741824) {
      return '${(sizeInBytes / 1073741824).toStringAsFixed(2)} GB';
    } else if (sizeInBytes >= 1048576) {
      return '${(sizeInBytes / 1048576).toStringAsFixed(1)} MB';
    } else if (sizeInBytes >= 1024) {
      return '${(sizeInBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '$sizeInBytes B';
  }
}
