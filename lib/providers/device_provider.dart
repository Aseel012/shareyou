import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/device.dart';

/// Holds the list of nearby devices shown on the Nearby screen.
/// Phase 1: seeded with static sample devices — the real Discovery
/// Manager will replace this data source in a later phase.
class DeviceListNotifier extends StateNotifier<List<DeviceModel>> {
  DeviceListNotifier()
      : super(const [
          DeviceModel(
            id: 'd1',
            name: "Aseel's Laptop",
            type: DeviceType.laptop,
            status: DeviceStatus.available,
            signalStrength: 92,
          ),
          DeviceModel(
            id: 'd2',
            name: 'Pixel 8 Pro',
            type: DeviceType.phone,
            status: DeviceStatus.available,
            signalStrength: 78,
          ),
          DeviceModel(
            id: 'd3',
            name: 'Galaxy Tab S9',
            type: DeviceType.tablet,
            status: DeviceStatus.connecting,
            signalStrength: 54,
          ),
          DeviceModel(
            id: 'd4',
            name: 'Office Desktop',
            type: DeviceType.desktop,
            status: DeviceStatus.offline,
            signalStrength: 0,
          ),
        ]);

  /// UI-only toggle used by the placeholder favorite icon in device tiles.
  void toggleFavorite(String id) {
    state = [
      for (final device in state)
        if (device.id == id)
          device.copyWith(isFavorite: !device.isFavorite)
        else
          device,
    ];
  }
}

final deviceListProvider =
    StateNotifierProvider<DeviceListNotifier, List<DeviceModel>>(
  (ref) => DeviceListNotifier(),
);

/// Whether the (placeholder) scanning animation should play on the Nearby
/// screen. Wired to a real Discovery Manager in a future phase.
final isScanningProvider = StateProvider<bool>((ref) => true);
