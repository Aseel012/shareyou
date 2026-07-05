import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/navigation_provider.dart';
import '../../widgets/app_bottom_nav.dart';
import '../history/history_screen.dart';
import '../nearby/nearby_screen.dart';
import '../settings/settings_screen.dart';
import 'home_dashboard.dart';

/// The app shell: holds the bottom navigation bar and swaps between the
/// four main tabs. Uses an IndexedStack so each tab keeps its scroll
/// position and animation state when switching back and forth.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: currentIndex,
          children: const [
            HomeDashboard(),
            NearbyScreen(),
            HistoryScreen(),
            SettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onTap: (index) =>
            ref.read(bottomNavIndexProvider.notifier).state = index,
      ),
    );
  }
}
