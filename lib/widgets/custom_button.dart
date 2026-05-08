import 'package:flutter/material.dart';

import '../core/constants/app_sizes.dart';
import '../core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isSecondary = false,
    this.height = AppSizes.buttonHeight,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isSecondary;
  final double height;

  @override
  Widget build(BuildContext context) {
    final foreground = isSecondary ? AppColors.primary : Colors.white;
    final background = isSecondary ? AppColors.primarySoft : AppColors.primary;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 18),
        label: Text(label.toUpperCase()),
        style: FilledButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          textStyle: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
