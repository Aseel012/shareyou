/// Represents a nearby discoverable device.
/// Phase 1: pure data holder, no discovery logic wired in yet.
enum DeviceType { phone, tablet, laptop, desktop, unknown }

enum DeviceStatus { available, connecting, connected, offline }

class DeviceModel {
  final String id;
  final String name;
  final DeviceType type;
  final DeviceStatus status;
  final int signalStrength; // 0-100, placeholder for UI only
  final bool isFavorite;

  const DeviceModel({
    required this.id,
    required this.name,
    this.type = DeviceType.phone,
    this.status = DeviceStatus.available,
    this.signalStrength = 80,
    this.isFavorite = false,
  });

  DeviceModel copyWith({
    String? id,
    String? name,
    DeviceType? type,
    DeviceStatus? status,
    int? signalStrength,
    bool? isFavorite,
  }) {
    return DeviceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      signalStrength: signalStrength ?? this.signalStrength,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
