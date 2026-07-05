import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/file_metadata.dart';
import '../models/transfer.dart';

/// Holds active/queued transfers shown on the Transfer & Receive screens.
/// Phase 1: static sample data only — the real Transfer Manager and
/// Chunk Manager will populate/update this in a later phase.
class TransferListNotifier extends StateNotifier<List<TransferModel>> {
  TransferListNotifier()
      : super([
          TransferModel(
            id: 't1',
            file: const FileMetadataModel(
              id: 'f1',
              fileName: 'Vacation_Movie.mp4',
              sizeInBytes: 4831838208, // ~4.5 GB
              category: FileCategory.video,
            ),
            deviceName: "Aseel's Laptop",
            state: TransferState.inProgress,
            progress: 0.62,
            speedMBps: 38.4,
            eta: const Duration(minutes: 2, seconds: 14),
          ),
          TransferModel(
            id: 't2',
            file: const FileMetadataModel(
              id: 'f2',
              fileName: 'Design_Assets.zip',
              sizeInBytes: 314572800, // 300 MB
              category: FileCategory.archive,
            ),
            deviceName: 'Pixel 8 Pro',
            state: TransferState.queued,
          ),
          TransferModel(
            id: 't3',
            file: const FileMetadataModel(
              id: 'f3',
              fileName: 'Project_Report.docx',
              sizeInBytes: 2097152, // 2 MB
              category: FileCategory.document,
            ),
            deviceName: 'Galaxy Tab S9',
            state: TransferState.paused,
            progress: 0.28,
          ),
        ]);
}

final transferListProvider =
    StateNotifierProvider<TransferListNotifier, List<TransferModel>>(
  (ref) => TransferListNotifier(),
);
