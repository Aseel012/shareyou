import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks which tab is selected on the Home shell's bottom navigation bar.
/// 0 = Home, 1 = Nearby, 2 = History, 3 = Settings.
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
