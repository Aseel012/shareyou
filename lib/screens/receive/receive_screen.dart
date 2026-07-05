import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_container.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../widgets/scan_radar.dart';

/// Screen shown while the device is visible/waiting to receive an
/// incoming transfer. Phase 1: static "waiting" state with the same
/// radar visual language as Nearby, tinted for receiving.
class ReceiveScreen extends StatelessWidget {
  const ReceiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: r.pagePadding),
              child: const AppTopBar(
                title: 'Receive',
                subtitle: 'Your device is discoverable',
                showBack: true,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  r.pagePadding,
                  AppDimens.space24,
                  r.pagePadding,
                  AppDimens.space24,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: r.maxContentWidth),
                    child: Column(
                      children: [
                        FadeSlideIn(
                          child: const ScanRadar(isScanning: true),
                        ),
                        const SizedBox(height: AppDimens.space24),
                        FadeSlideIn(
                          delay: const Duration(milliseconds: 100),
                          child: Text(
                            'Waiting for a nearby sender…',
                            style: AppTextStyles.h3,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: AppDimens.space8),
                        FadeSlideIn(
                          delay: const Duration(milliseconds: 140),
                          child: Text(
                            'Keep this screen open so other devices\ncan find and send files to you',
                            style: AppTextStyles.body,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: AppDimens.space32),
                        FadeSlideIn(
                          delay: const Duration(milliseconds: 180),
                          child: AppContainer(
                            gradient: AppColors.cardGradient,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.info.withOpacity(
                                          0.14,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          AppDimens.radiusSmall,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.qr_code_scanner_rounded,
                                        color: AppColors.info,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: AppDimens.space12),
                                    Expanded(
                                      child: Text(
                                        'Or ask the sender to scan your QR code',
                                        style: AppTextStyles.body,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppDimens.space16),
                                AppButton(
                                  label: 'Show My QR Code',
                                  icon: Icons.qr_code_rounded,
                                  variant: AppButtonVariant.outline,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
