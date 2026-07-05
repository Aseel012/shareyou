import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_container.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../providers/transfer_provider.dart';
import '../../widgets/transfer_progress_card.dart';

/// Shows outgoing transfers to a selected device. Reached from tapping a
/// device on the Nearby screen. Purely presentational for Phase 1 — the
/// progress values come from static sample data.
class TransferScreen extends ConsumerWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final transfers = ref.watch(transferListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: r.pagePadding),
              child: const AppTopBar(
                title: 'Transfer',
                subtitle: 'Sending to selected device',
                showBack: true,
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
                        const SizedBox(height: AppDimens.space8),
                        FadeSlideIn(
                          child: AppContainer(
                            padding: const EdgeInsets.all(AppDimens.space20),
                            gradient: AppColors.cardGradient,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: AppColors.accentStart
                                            .withOpacity(0.14),
                                        borderRadius: BorderRadius.circular(
                                          AppDimens.radiusSmall,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add_rounded,
                                        color: AppColors.accentStart,
                                      ),
                                    ),
                                    const SizedBox(width: AppDimens.space12),
                                    Expanded(
                                      child: Text(
                                        'Add more files to this transfer',
                                        style: AppTextStyles.bodyStrong,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppDimens.space16),
                                AppButton(
                                  label: 'Choose Files',
                                  icon: Icons.folder_open_rounded,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimens.space24),
                        FadeSlideIn(
                          delay: const Duration(milliseconds: 100),
                          child: Text(
                            'Queue (${transfers.length})',
                            style: AppTextStyles.h3,
                          ),
                        ),
                        const SizedBox(height: AppDimens.space12),
                        for (int i = 0; i < transfers.length; i++)
                          FadeSlideIn(
                            delay: Duration(milliseconds: 140 + i * 70),
                            child: TransferProgressCard(
                              transfer: transfers[i],
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
