import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Simple placeholder toggles/values for the Settings screen.
/// No persistence yet — will be backed by Shared Preferences /
/// a real Settings Manager in a later phase.
final deviceNameProvider = StateProvider<String>((ref) => 'My Device');
final autoAcceptProvider = StateProvider<bool>((ref) => false);
final notificationsEnabledProvider = StateProvider<bool>((ref) => true);
final encryptionEnabledProvider = StateProvider<bool>((ref) => true);
final resumeEnabledProvider = StateProvider<bool>((ref) => true);
final chunkSizeMBProvider = StateProvider<double>((ref) => 4);
