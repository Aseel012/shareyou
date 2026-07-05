import 'file_metadata.dart';

enum TransferState { queued, inProgress, paused, completed, failed }

/// Represents an active (or queued) transfer between two devices.
/// Phase 1: static data shape only, feeds the Transfer/Receive screens.
class TransferModel {
  final String id;
  final FileMetadataModel file;
  final String deviceName;
  final TransferState state;
  final double progress; // 0.0 - 1.0
  final double speedMBps;
  final Duration eta;

  const TransferModel({
    required this.id,
    required this.file,
    required this.deviceName,
    this.state = TransferState.queued,
    this.progress = 0.0,
    this.speedMBps = 0.0,
    this.eta = Duration.zero,
  });

  TransferModel copyWith({
    TransferState? state,
    double? progress,
    double? speedMBps,
    Duration? eta,
  }) {
    return TransferModel(
      id: id,
      file: file,
      deviceName: deviceName,
      state: state ?? this.state,
      progress: progress ?? this.progress,
      speedMBps: speedMBps ?? this.speedMBps,
      eta: eta ?? this.eta,
    );
  }
}
