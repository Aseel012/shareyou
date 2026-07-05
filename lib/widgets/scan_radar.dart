import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// A pulsing radar animation used at the top of the Nearby screen to
/// indicate that the app is scanning for devices. Purely decorative —
/// wired to isScanningProvider from outside.
class ScanRadar extends StatefulWidget {
  final bool isScanning;
  final double size;

  const ScanRadar({super.key, required this.isScanning, this.size = 220});

  @override
  State<ScanRadar> createState() => _ScanRadarState();
}

class _ScanRadarState extends State<ScanRadar>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat();

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.isScanning) ..._buildPulseRings(),
          Container(
            width: widget.size * 0.4,
            height: widget.size * 0.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentStart.withOpacity(0.5),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.wifi_tethering_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPulseRings() {
    return List.generate(3, (index) {
      return AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final delay = index * 0.33;
          double t = (_pulseController.value + delay) % 1.0;
          return Opacity(
            opacity: (1 - t).clamp(0.0, 1.0) * 0.5,
            child: Container(
              width: widget.size * (0.4 + t * 0.6),
              height: widget.size * (0.4 + t * 0.6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accentSoft,
                  width: 1.5,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
