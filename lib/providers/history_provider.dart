import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/file_metadata.dart';
import '../models/history.dart';

/// Holds completed transfer records for the History screen.
/// Phase 1: static sample data — a real History Manager backed by Isar
/// will replace this in a later phase.
class HistoryListNotifier extends StateNotifier<List<HistoryModel>> {
  HistoryListNotifier()
      : super([
          HistoryModel(
            id: 'h1',
            file: const FileMetadataModel(
              id: 'f4',
              fileName: 'Family_Photos.zip',
              sizeInBytes: 734003200,
              category: FileCategory.archive,
            ),
            deviceName: "Aseel's Laptop",
            direction: HistoryDirection.sent,
            result: HistoryResult.success,
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          ),
          HistoryModel(
            id: 'h2',
            file: const FileMetadataModel(
              id: 'f5',
              fileName: 'App-release.apk',
              sizeInBytes: 45088768,
              category: FileCategory.apk,
            ),
            deviceName: 'Pixel 8 Pro',
            direction: HistoryDirection.received,
            result: HistoryResult.success,
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          ),
          HistoryModel(
            id: 'h3',
            file: const FileMetadataModel(
              id: 'f6',
              fileName: 'Quarterly_Report.pdf',
              sizeInBytes: 5242880,
              category: FileCategory.document,
            ),
            deviceName: 'Office Desktop',
            direction: HistoryDirection.sent,
            result: HistoryResult.failed,
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
          ),
          HistoryModel(
            id: 'h4',
            file: const FileMetadataModel(
              id: 'f7',
              fileName: 'OS_Image.iso',
              sizeInBytes: 4939212390,
              category: FileCategory.other,
            ),
            deviceName: 'Galaxy Tab S9',
            direction: HistoryDirection.received,
            result: HistoryResult.cancelled,
            timestamp: DateTime.now().subtract(const Duration(days: 2)),
          ),
        ]);
}

final historyListProvider =
    StateNotifierProvider<HistoryListNotifier, List<HistoryModel>>(
  (ref) => HistoryListNotifier(),
);
