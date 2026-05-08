import 'package:flutter/material.dart';

import '../core/constants/app_sizes.dart';
import '../core/theme/app_colors.dart';
import 'custom_card.dart';

class PetCard extends StatelessWidget {
  const PetCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.buttonLabel,
    this.onPressed,
    this.onTap,
    this.useNetworkImage = false,
  });

  final String title;
  final String subtitle;
  final String image;
  final String? buttonLabel;
  final VoidCallback? onPressed;
  final VoidCallback? onTap;
  final bool useNetworkImage;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                if (buttonLabel != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    height: AppSizes.smallButtonHeight,
                    child: FilledButton(
                      onPressed: onPressed,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                      ),
                      child: Text(buttonLabel!),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: useNetworkImage
                ? Image.network(image, width: 96, height: 82, fit: BoxFit.cover)
                : Image.asset(
                    image,
                    width: 96,
                    height: 82,
                    fit: BoxFit.cover,
                    cacheWidth: 320,
                  ),
          ),
        ],
      ),
    );
  }
}
