import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../models/service_model.dart';
import '../../services/activity_log_service.dart';
import '../../services/pet_data_service.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/category_item.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/pet_card.dart';
import '../../widgets/search_box.dart';
import '../../widgets/section_header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSizes.screenMaxWidth,
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.xl,
                AppSizes.bottomBarHeight + AppSpacing.xl,
              ),
              children: [
                Row(
                  children: [
                    Material(
                      color: AppColors.primarySoft,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          ActivityLogService.add('Opened profile');
                          Navigator.pushNamed(context, AppRoutes.profile);
                        },
                        child: const SizedBox(
                          width: AppSizes.avatar,
                          height: AppSizes.avatar,
                          child: Icon(
                            Icons.person_outline_rounded,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, Karina',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Good Morning!',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Activity Log',
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.activityLog),
                      icon: const Icon(Icons.notifications_none_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                const SearchBox(hint: 'search'),
                const SizedBox(height: AppSpacing.xl),
                PetCard(
                  title: 'In Love With Pets?',
                  subtitle: 'Get all what you need for them',
                  image:
                      'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?auto=format&fit=crop&w=900&q=80',
                  useNetworkImage: true,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.shop),
                ),
                const SizedBox(height: AppSpacing.xl),
                SectionHeader(
                  title: 'Shop',
                  onActionTap: () =>
                      Navigator.pushNamed(context, AppRoutes.shop),
                ),
                const SizedBox(height: AppSpacing.lg),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 2.6,
                  ),
                  itemBuilder: (context, index) {
                    final item = PetDataService.shopItems[index];
                    return _DashboardShopCard(
                      item: item,
                      onTap: () => _openShopCategory(context, item),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                SectionHeader(
                  title: 'Category',
                  onActionTap: () =>
                      Navigator.pushNamed(context, AppRoutes.categoryList),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: PetDataService.categories
                      .map(
                        (item) => CategoryItem(
                          title: item.title,
                          image: item.image,
                          onTap: () => Navigator.pushNamed(context, item.route),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  'Event',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.lg),
                PetCard(
                  title: 'Join a special training\nfor your pet',
                  subtitle: '20.05.2026\nWatch the video before the event',
                  image: AppAssets.event,
                  buttonLabel: 'See More',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.training),
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.training),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  'Community',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.lg),
                PetCard(
                  title: 'Connect and share with\ncommunities!',
                  subtitle: '',
                  image: AppAssets.community,
                  buttonLabel: 'See More',
                  onTap: () => _openCommunity(context),
                  onPressed: () => _openCommunity(context),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }

  void _openShopCategory(BuildContext context, ServiceModel item) {
    ActivityLogService.add('Opened ${item.title} category');
    Navigator.pushNamed(context, AppRoutes.shopCategory, arguments: item);
  }

  Future<void> _openCommunity(BuildContext context) async {
    ActivityLogService.add('Opened Telegram community');
    final opened = await launchUrl(
      Uri.parse('https://t.me/+b4lasqjN2I82YWZi'),
      mode: LaunchMode.externalApplication,
    );

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open Telegram group'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

class _DashboardShopCard extends StatelessWidget {
  const _DashboardShopCard({required this.item, required this.onTap});

  final ServiceModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Image.asset(
              item.image,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
              cacheWidth: 120,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
