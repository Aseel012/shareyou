/// Represents a single chunk/packet within a transfer.
/// Phase 1: structural placeholder matching the documented packet header —
/// no encoding/decoding logic implemented yet.
class PacketModel {
  final String packetId;
  final String transferId;
  final String senderId;
  final String receiverId;
  final int chunkNumber;
  final int chunkSize;
  final String checksum;

  const PacketModel({
    required this.packetId,
    required this.transferId,
    required this.senderId,
    required this.receiverId,
    required this.chunkNumber,
    required this.chunkSize,
    required this.checksum,
  });
}
