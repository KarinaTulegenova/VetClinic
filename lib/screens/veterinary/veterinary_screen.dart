import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../models/doctor_model.dart';
import '../../models/service_model.dart';
import '../../services/activity_log_service.dart';
import '../../services/cart_service.dart';
import '../../services/pet_data_service.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/category_item.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/pet_card.dart';
import '../../widgets/search_box.dart';
import '../../widgets/section_header.dart';

class VeterinaryScreen extends StatelessWidget {
  const VeterinaryScreen({super.key});

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
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      AppConstants.city,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                PetCard(
                  title: 'Lets Find Specialist\nDoctor for Your Pet!',
                  subtitle: '',
                  image: AppAssets.vetDoctor,
                ),
                const SizedBox(height: AppSpacing.lg),
                Container(
                  height: 46,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.appointments),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_note_rounded, size: 20),
                        SizedBox(width: AppSpacing.sm),
                        Text('View Appointments'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const SearchBox(),
                const SizedBox(height: AppSpacing.lg),
                SectionHeader(
                  title: 'Our Services',
                  onActionTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.serviceList,
                    arguments: PetDataService.veterinaryServices,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: PetDataService.veterinaryServices
                      .map(
                        (service) => CategoryItem(
                          title: service.title,
                          image: service.image,
                          icon: _serviceIcon(service.title),
                          onTap: () => _addServiceToCart(context, service),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  'Best Specialists Nearby',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.lg),
                ...PetDataService.doctors.map(
                  (doctor) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                    child: _DoctorListTile(doctor: doctor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
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

  IconData _serviceIcon(String title) {
    return switch (title) {
      'Vaccinations' => Icons.vaccines_rounded,
      'Operations' => Icons.medical_services_rounded,
      'Behaviorals' => Icons.psychology_alt_rounded,
      'Dentistry' => Icons.health_and_safety_rounded,
      _ => Icons.pets_rounded,
    };
  }
}

class _DoctorListTile extends StatelessWidget {
  const _DoctorListTile({required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () {
        ActivityLogService.add('Selected doctor ${doctor.name}');
        Navigator.pushNamed(context, AppRoutes.doctorDetail, arguments: doctor);
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Image.asset(
              doctor.image,
              width: AppSizes.cardImage,
              height: AppSizes.cardImage,
              fit: BoxFit.cover,
              cacheWidth: 260,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  doctor.specialty,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    Text(
                      ' ${doctor.rating}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    Text(
                      ' ${doctor.distance}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
