import 'package:flutter/material.dart';

import '../core/constants/app_routes.dart';
import '../core/constants/app_sizes.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/navigation_utils.dart';
import '../services/activity_log_service.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key, required this.currentIndex});

  final int currentIndex;

  static const List<_NavItem> _items = [
    _NavItem('Home', Icons.home_outlined, AppRoutes.dashboard),
    _NavItem('Service', Icons.favorite_border_rounded, AppRoutes.veterinary),
    _NavItem('Shop', Icons.shopping_cart_rounded, AppRoutes.shop),
    _NavItem('History', Icons.access_time_rounded, AppRoutes.activityLog),
    _NavItem('Training', Icons.school_outlined, AppRoutes.training),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.bottomBarHeight,
      padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.sm),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final isSelected = index == currentIndex;
          final color = isSelected ? AppColors.primary : AppColors.muted;
          final child = index == 2
              ? Center(child: Icon(item.icon, color: Colors.white, size: 30))
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      color: isSelected && index == 2 ? Colors.white : color,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      item.label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isSelected && index == 2 ? Colors.white : color,
                      ),
                    ),
                  ],
                );

          return InkWell(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            onTap: () {
              if (!isSelected) {
                ActivityLogService.add('Navigated to ${item.label}');
                NavigationUtils.openRoot(context, item.route);
              }
            },
            child: index == 2
                ? Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 24,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: child,
                  )
                : SizedBox(width: 64, child: child),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.label, this.icon, this.route);

  final String label;
  final IconData icon;
  final String route;
}
