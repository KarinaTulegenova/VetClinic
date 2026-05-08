import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/navigation_utils.dart';
import '../../models/service_model.dart';
import '../../services/activity_log_service.dart';
import '../../services/cart_service.dart';
import '../../services/pet_data_service.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/pet_card.dart';
import '../../widgets/search_box.dart';
import '../../widgets/section_header.dart';

class GroomingScreen extends StatelessWidget {
  const GroomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Grooming'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.screenMaxWidth),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              PetCard(
                title: '60% OFF',
                subtitle: 'On hair & spa treatment',
                image: AppAssets.grooming,
              ),
              const SizedBox(height: AppSpacing.lg),
              const SearchBox(),
              const SizedBox(height: AppSpacing.lg),
              SectionHeader(
                title: 'Our Services',
                onActionTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.serviceList,
                  arguments: PetDataService.groomingServices,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: PetDataService.groomingServices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSpacing.lg,
                  crossAxisSpacing: AppSpacing.lg,
                  childAspectRatio: .92,
                ),
                itemBuilder: (context, index) {
                  final service = PetDataService.groomingServices[index];
                  return _ServiceGridTile(
                    service: service,
                    onTap: () => _addServiceToCart(context, service),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addServiceToCart(BuildContext context, ServiceModel service) {
    CartService.add(service);
    ActivityLogService.add('Added ${service.title} service to cart');
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('${service.title} added to cart'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'Cart',
          onPressed: () {
            messenger.hideCurrentSnackBar();
            Navigator.pushNamed(context, AppRoutes.cart);
          },
        ),
      ),
    );
  }
}

class _ServiceGridTile extends StatelessWidget {
  const _ServiceGridTile({required this.service, required this.onTap});

  final ServiceModel service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Icon(
                _iconFor(service.title),
                color: AppColors.primary,
                size: 34,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            service.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          if (service.subtitle != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              service.subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _iconFor(String title) {
    return switch (title) {
      'Bathing & Drying' => Icons.shower_rounded,
      'Hair Triming' => Icons.content_cut_rounded,
      'Nail Trimming' => Icons.back_hand_rounded,
      'Ear Cleaning' => Icons.hearing_rounded,
      'Dental Brushing' => Icons.cleaning_services_rounded,
      'Spa Treatment' => Icons.spa_rounded,
      _ => Icons.pets_rounded,
    };
  }
}
