import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Placeholder theme-mode provider. Phase 1 ships dark-only, but keeping
/// this here means Settings can wire up a real toggle later without any
/// screen-level refactor.
final isDarkModeProvider = StateProvider<bool>((ref) => true);
