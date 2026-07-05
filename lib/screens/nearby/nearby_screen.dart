import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../providers/device_provider.dart';
import '../../widgets/device_tile.dart';
import '../../widgets/scan_radar.dart';
import '../transfer/transfer_screen.dart';

/// Nearby devices discovery screen. Shows a radar animation while
/// "scanning" and a list of placeholder devices below it.
class NearbyScreen extends ConsumerWidget {
  const NearbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final devices = ref.watch(deviceListProvider);
    final isScanning = ref.watch(isScanningProvider);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.pagePadding),
            child: AppTopBar(
              title: 'Nearby',
              subtitle: isScanning
                  ? 'Scanning for devices…'
                  : '${devices.length} devices found',
              trailingIcon: Icons.refresh_rounded,
              onTrailingTap: () =>
                  ref.read(isScanningProvider.notifier).state = true,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                r.pagePadding,
                AppDimens.space8,
                r.pagePadding,
                AppDimens.space24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: r.maxContentWidth),
                  child: Column(
                    children: [
                      const SizedBox(height: AppDimens.space16),
                      FadeSlideIn(
                        child: ScanRadar(isScanning: isScanning),
                      ),
                      const SizedBox(height: AppDimens.space8),
                      FadeSlideIn(
                        delay: const Duration(milliseconds: 80),
                        child: Text(
                          'Make sure the other device also has\nSwiftShare AI open',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption,
                        ),
                      ),
                      const SizedBox(height: AppDimens.space24),
                      FadeSlideIn(
                        delay: const Duration(milliseconds: 120),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Available Devices',
                            style: AppTextStyles.h3,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.space12),
                      for (int i = 0; i < devices.length; i++)
                        FadeSlideIn(
                          delay: Duration(milliseconds: 140 + i * 60),
                          child: DeviceTile(
                            device: devices[i],
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const TransferScreen(),
                                ),
                              );
                            },
                            onFavoriteTap: () => ref
                                .read(deviceListProvider.notifier)
                                .toggleFavorite(devices[i].id),
                          ),
                        ),
                      const SizedBox(height: AppDimens.space80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
