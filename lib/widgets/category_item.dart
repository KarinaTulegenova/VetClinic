import 'package:flutter/material.dart';

import '../core/constants/app_sizes.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    this.icon,
  });

  final String title;
  final String image;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon == null
                ? ClipOval(
                    child: Image.asset(
                      image,
                      width: AppSizes.categoryImage,
                      height: AppSizes.categoryImage,
                      fit: BoxFit.cover,
                      cacheWidth: 160,
                    ),
                  )
                : Container(
                    width: AppSizes.categoryImage,
                    height: AppSizes.categoryImage,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: .12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: Theme.of(context).colorScheme.primary,
                      size: 28,
                    ),
                  ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
