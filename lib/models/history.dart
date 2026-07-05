import 'file_metadata.dart';

enum HistoryDirection { sent, received }

enum HistoryResult { success, failed, cancelled }

/// A completed (or attempted) transfer record for the History screen.
class HistoryModel {
  final String id;
  final FileMetadataModel file;
  final String deviceName;
  final HistoryDirection direction;
  final HistoryResult result;
  final DateTime timestamp;

  const HistoryModel({
    required this.id,
    required this.file,
    required this.deviceName,
    required this.direction,
    required this.result,
    required this.timestamp,
  });
}
