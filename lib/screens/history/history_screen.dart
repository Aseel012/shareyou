import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../models/history.dart';
import '../../providers/history_provider.dart';
import '../../widgets/history_tile.dart';

enum _HistoryFilter { all, sent, received }

/// History tab: filterable list of past transfers.
/// Phase 1: filtering happens client-side over the static sample list.
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  _HistoryFilter _filter = _HistoryFilter.all;

  List<HistoryModel> _applyFilter(List<HistoryModel> items) {
    switch (_filter) {
      case _HistoryFilter.sent:
        return items
            .where((e) => e.direction == HistoryDirection.sent)
            .toList();
      case _HistoryFilter.received:
        return items
            .where((e) => e.direction == HistoryDirection.received)
            .toList();
      case _HistoryFilter.all:
        return items;
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final allHistory = ref.watch(historyListProvider);
    final filtered = _applyFilter(allHistory);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.pagePadding),
            child: const AppTopBar(
              title: 'History',
              subtitle: 'Your past transfers',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.pagePadding),
            child: Row(
              children: [
                _FilterChip(
                  label: 'All',
                  selected: _filter == _HistoryFilter.all,
                  onTap: () => setState(() => _filter = _HistoryFilter.all),
                ),
                const SizedBox(width: AppDimens.space8),
                _FilterChip(
                  label: 'Sent',
                  selected: _filter == _HistoryFilter.sent,
                  onTap: () => setState(() => _filter = _HistoryFilter.sent),
                ),
                const SizedBox(width: AppDimens.space8),
                _FilterChip(
                  label: 'Received',
                  selected: _filter == _HistoryFilter.received,
                  onTap: () =>
                      setState(() => _filter = _HistoryFilter.received),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.space8),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      'No transfers yet',
                      style: AppTextStyles.body,
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      r.pagePadding,
                      AppDimens.space8,
                      r.pagePadding,
                      AppDimens.space24,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: r.maxContentWidth,
                        ),
                        child: Column(
                          children: [
                            for (int i = 0; i < filtered.length; i++)
                              FadeSlideIn(
                                delay: Duration(milliseconds: i * 60),
                                child: HistoryTile(item: filtered[i]),
                              ),
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.space16,
          vertical: AppDimens.space8,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentStart : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          border: Border.all(
            color: selected ? AppColors.accentStart : AppColors.surfaceBorder,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: selected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
