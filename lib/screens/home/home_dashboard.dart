import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../providers/history_provider.dart';
import '../../providers/navigation_provider.dart';
import '../../widgets/action_card.dart';
import '../../widgets/history_tile.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_card.dart';
import '../receive/receive_screen.dart';

/// Content shown on the "Home" tab: greeting header, primary Send/Receive
/// actions, quick stats, and a short recent-activity preview.
class HomeDashboard extends ConsumerWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final history = ref.watch(historyListProvider).take(2).toList();

    return SingleChildScrollView(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              FadeSlideIn(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome back 👋', style: AppTextStyles.body),
                          const SizedBox(height: AppDimens.space4),
                          Text('SwiftShare AI', style: AppTextStyles.h1),
                        ],
                      ),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.surfaceBorder),
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.space24),

              // Primary actions
              FadeSlideIn(
                delay: const Duration(milliseconds: 80),
                child: Row(
                  children: [
                    Expanded(
                      child: ActionCard(
                        icon: Icons.upload_rounded,
                        title: 'Send',
                        subtitle: 'Choose files to share',
                        gradient: AppColors.primaryGradient,
                        onTap: () => ref
                            .read(bottomNavIndexProvider.notifier)
                            .state = 1,
                      ),
                    ),
                    const SizedBox(width: AppDimens.space16),
                    Expanded(
                      child: ActionCard(
                        icon: Icons.download_rounded,
                        title: 'Receive',
                        subtitle: 'Wait for incoming files',
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.success, Color(0xFF1E9E76)],
                        ),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ReceiveScreen(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.space24),

              // Quick stats
              FadeSlideIn(
                delay: const Duration(milliseconds: 140),
                child: const SectionHeader(title: 'This Week'),
              ),
              const SizedBox(height: AppDimens.space8),
              FadeSlideIn(
                delay: const Duration(milliseconds: 160),
                child: GridView.count(
                  crossAxisCount: r.isMobile ? 3 : 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: AppDimens.space12,
                  mainAxisSpacing: AppDimens.space12,
                  childAspectRatio: 0.95,
                  children: const [
                    StatCard(
                      icon: Icons.north_east_rounded,
                      value: '128',
                      label: 'Files sent',
                      accentColor: AppColors.accentStart,
                    ),
                    StatCard(
                      icon: Icons.south_west_rounded,
                      value: '64',
                      label: 'Files received',
                      accentColor: AppColors.success,
                    ),
                    StatCard(
                      icon: Icons.storage_rounded,
                      value: '9.4 GB',
                      label: 'Data moved',
                      accentColor: AppColors.info,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.space24),

              // Recent activity preview
              FadeSlideIn(
                delay: const Duration(milliseconds: 220),
                child: SectionHeader(
                  title: 'Recent Activity',
                  actionLabel: 'See all',
                  onActionTap: () =>
                      ref.read(bottomNavIndexProvider.notifier).state = 2,
                ),
              ),
              const SizedBox(height: AppDimens.space8),
              FadeSlideIn(
                delay: const Duration(milliseconds: 260),
                child: Column(
                  children: [
                    for (final item in history) HistoryTile(item: item),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.space48),
            ],
          ),
        ),
      ),
    );
  }
}
