import 'package:flutter/material.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/navigation_utils.dart';
import '../../models/activity_log_model.dart';
import '../../services/activity_log_service.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/custom_card.dart';

class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = ActivityLogService.groupedLogs();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => NavigationUtils.backOrDashboard(context),
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.primary,
          ),
        ),
        title: const Text('Activity Log'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.screenMaxWidth),
          child: groups.isEmpty
              ? const _EmptyActivityLog()
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    AppSpacing.xl,
                    AppSpacing.xl,
                    AppSizes.bottomBarHeight + AppSpacing.xl,
                  ),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final entry = groups.entries.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          CustomCard(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            child: Column(
                              children: List.generate(entry.value.length, (
                                logIndex,
                              ) {
                                final log = entry.value[logIndex];
                                return Column(
                                  children: [
                                    _ActivityTile(log: log),
                                    if (logIndex != entry.value.length - 1)
                                      const Divider(height: AppSpacing.md),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.log});

  final ActivityLog log;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(AppSpacing.sm),
      leading: Container(
        width: AppSizes.iconButton,
        height: AppSizes.iconButton,
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(_iconFor(log.action), color: AppColors.primary),
      ),
      title: Text(
        log.action,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        _timeLabel(log.time),
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
      ),
    );
  }

  IconData _iconFor(String action) {
    final normalized = action.toLowerCase();
    if (normalized.contains('search')) {
      return Icons.search_rounded;
    }
    if (normalized.contains('animal')) {
      return Icons.pets_rounded;
    }
    if (normalized.contains('doctor')) {
      return Icons.medical_services_outlined;
    }
    if (normalized.contains('appointment')) {
      return Icons.event_available_outlined;
    }
    if (normalized.contains('profile')) {
      return Icons.person_outline_rounded;
    }
    return Icons.access_time_rounded;
  }

  String _timeLabel(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _EmptyActivityLog extends StatelessWidget {
  const _EmptyActivityLog();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.access_time_rounded,
              size: 48,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No activity yet',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Search for cats, open animals, or select appointments to build activity history.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
