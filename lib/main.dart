import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: SwiftShareApp()));
}

/// Root widget for SwiftShare AI.
/// Phase 1: wires up theme + Riverpod scope and boots into the Splash
/// screen. No platform channel / permission logic is initialized here yet.
class SwiftShareApp extends StatelessWidget {
  const SwiftShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwiftShare AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}
