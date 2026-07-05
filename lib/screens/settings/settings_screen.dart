import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/app_container.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/section_header.dart';
import '../../widgets/settings_tile.dart';

/// Settings tab, grouped into sections. Every switch here is wired to a
/// placeholder Riverpod provider only — no persistence or real device
/// behavior yet.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final deviceName = ref.watch(deviceNameProvider);
    final autoAccept = ref.watch(autoAcceptProvider);
    final notifications = ref.watch(notificationsEnabledProvider);
    final encryption = ref.watch(encryptionEnabledProvider);
    final resume = ref.watch(resumeEnabledProvider);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.pagePadding),
            child: const AppTopBar(
              title: 'Settings',
              subtitle: 'Preferences & device info',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile card
                      FadeSlideIn(
                        child: AppContainer(
                          gradient: AppColors.cardGradient,
                          child: Row(
                            children: [
                              Container(
                                width: AppDimens.avatarSize,
                                height: AppDimens.avatarSize,
                                decoration: const BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: AppDimens.space16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      deviceName,
                                      style: AppTextStyles.bodyStrong,
                                    ),
                                    const SizedBox(height: AppDimens.space4),
                                    Text(
                                      'Tap to rename this device',
                                      style: AppTextStyles.caption,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: AppColors.textMuted,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.space24),

                      // Transfer section
                      FadeSlideIn(
                        delay: const Duration(milliseconds: 80),
                        child: const SectionHeader(title: 'Transfer'),
                      ),
                      FadeSlideIn(
                        delay: const Duration(milliseconds: 100),
                        child: AppContainer(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.space16,
                          ),
                          child: Column(
                            children: [
                              SettingsTile(
                                icon: Icons.download_done_rounded,
                                title: 'Auto-Accept Files',
                                subtitle: 'Skip manual confirmation',
                                switchValue: autoAccept,
                                onSwitchChanged: (v) => ref
                                    .read(autoAcceptProvider.notifier)
                                    .state = v,
                              ),
                              const Divider(),
                              SettingsTile(
                                icon: Icons.restore_rounded,
                                title: 'Resume Interrupted Transfers',
                                subtitle: 'Continue where it left off',
                                switchValue: resume,
                                onSwitchChanged: (v) => ref
                                    .read(resumeEnabledProvider.notifier)
                                    .state = v,
                              ),
                              const Divider(),
                              SettingsTile(
                                icon: Icons.folder_rounded,
                                title: 'Download Folder',
                                subtitle: '/storage/SwiftShare',
                                showChevron: true,
                                onTap: () {},
                              ),
                              const Divider(),
                              SettingsTile(
                                icon: Icons.speed_rounded,
                                title: 'Chunk Size',
                                subtitle: '4 MB per chunk',
                                showChevron: true,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.space24),

                      // Security section
                      FadeSlideIn(
                        delay: const Duration(milliseconds: 140),
                        child: const SectionHeader(title: 'Security'),
                      ),
                      FadeSlideIn(
                        delay: const Duration(milliseconds: 160),
                        child: AppContainer(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.space16,
                          ),
                          child: Column(
                            children: [
                              SettingsTile(
                                icon: Icons.lock_rounded,
                                title: 'AES-256 Encryption',
                                subtitle: 'Encrypt every transfer',
                                switchValue: encryption,
                                onSwitchChanged: (v) => ref
                                    .read(encryptionEnabledProvider.notifier)
                                    .state = v,
                              ),
                              const Divider(),
                              SettingsTile(
                                icon: Icons.verified_user_rounded,
                                title: 'Device Verification',
                                subtitle: 'Confirm new device pairing',
                                showChevron: true,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.space24),

                      // General section
                      FadeSlideIn(
                        delay: const Duration(milliseconds: 200),
                        child: const SectionHeader(title: 'General'),
                      ),
                      FadeSlideIn(
                        delay: const Duration(milliseconds: 220),
                        child: AppContainer(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.space16,
                          ),
                          child: Column(
                            children: [
                              SettingsTile(
                                icon: Icons.notifications_rounded,
                                title: 'Notifications',
                                subtitle: 'Transfer alerts',
                                switchValue: notifications,
                                onSwitchChanged: (v) => ref
                                    .read(
                                      notificationsEnabledProvider.notifier,
                                    )
                                    .state = v,
                              ),
                              const Divider(),
                              SettingsTile(
                                icon: Icons.dark_mode_rounded,
                                title: 'Dark Mode',
                                subtitle: 'Always on for now',
                                showChevron: true,
                                onTap: () {},
                              ),
                              const Divider(),
                              SettingsTile(
                                icon: Icons.language_rounded,
                                title: 'Language',
                                subtitle: 'English',
                                showChevron: true,
                                onTap: () {},
                              ),
                              const Divider(),
                              SettingsTile(
                                icon: Icons.info_outline_rounded,
                                title: 'About SwiftShare AI',
                                subtitle: 'Version 0.1.0 (Phase 1)',
                                showChevron: true,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.space48),
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
