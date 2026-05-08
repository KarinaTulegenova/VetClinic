import 'package:flutter/material.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../services/pet_data_service.dart';
import '../../widgets/category_item.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.primary,
          ),
        ),
        title: const Text('Categories'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppSpacing.xl),
        itemCount: PetDataService.categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.lg,
          crossAxisSpacing: AppSpacing.lg,
        ),
        itemBuilder: (context, index) {
          final item = PetDataService.categories[index];
          return CategoryItem(
            title: item.title,
            image: item.image,
            onTap: () => Navigator.pushNamed(context, item.route),
          );
        },
      ),
    );
  }
}
