import 'package:flutter/material.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../models/service_model.dart';
import '../../services/activity_log_service.dart';
import '../../services/cart_service.dart';
import '../../services/pet_data_service.dart';
import '../../widgets/custom_card.dart';

class ShopCategoryScreen extends StatelessWidget {
  const ShopCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = _categoryFromArgs(context);
    final products = _productsFor(category);

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
        title: Text(category.title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.screenMaxWidth),
          child: ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.xl),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final icon = _iconFor(category.title, index);
              final color = _iconColor(index);
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: CustomCard(
                  onTap: () => _addToCart(context, product),
                  child: Row(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: .14),
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                        child: Icon(icon, color: color, size: 34),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              product.subtitle ?? 'PetGuardian curated item',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.muted),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              _formatPrice(product.price),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  ServiceModel _categoryFromArgs(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is ServiceModel) {
      return args;
    }
    return PetDataService.shopItems.first;
  }

  List<ServiceModel> _productsFor(ServiceModel category) {
    return _shopProductCatalog[category.title] ?? _shopProductCatalog['Pets']!;
  }

  IconData _iconFor(String category, int index) {
    final icons = _shopProductIcons[category];
    if (icons == null || icons.isEmpty) {
      return _categoryIcons[category] ?? Icons.pets_rounded;
    }
    return icons[index % icons.length];
  }

  Color _iconColor(int index) {
    const colors = [
      AppColors.primary,
      AppColors.success,
      AppColors.warning,
      Color(0xFF7C7BEF),
      Color(0xFFE85D8E),
      Color(0xFF35A7A0),
    ];
    return colors[index % colors.length];
  }

  void _addToCart(BuildContext context, ServiceModel product) {
    CartService.add(product);
    ActivityLogService.add('Added ${product.title} to cart');
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('${product.title} added to cart'),
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

String _formatPrice(int value) {
  final raw = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < raw.length; i++) {
    final remaining = raw.length - i;
    buffer.write(raw[i]);
    if (remaining > 1 && remaining % 3 == 1) {
      buffer.write(' ');
    }
  }
  return '${buffer.toString()} ₸';
}

const Map<String, List<ServiceModel>> _shopProductCatalog = {
  'Pets': [
    ServiceModel(
      title: 'Playful Kittens',
      subtitle: 'Friendly little companions for calm homes',
      image: '',
      price: 45000,
    ),
    ServiceModel(
      title: 'Tiny Puppies',
      subtitle: 'Social pups ready for daily walks and care',
      image: '',
      price: 55000,
    ),
    ServiceModel(
      title: 'House Bunnies',
      subtitle: 'Gentle pets with soft coats and quiet habits',
      image: '',
      price: 18000,
    ),
    ServiceModel(
      title: 'Colorful Birds',
      subtitle: 'Bright singers for a lively pet corner',
      image: '',
      price: 12000,
    ),
    ServiceModel(
      title: 'Small Hamsters',
      subtitle: 'Easy-care pets with cozy starter needs',
      image: '',
      price: 8000,
    ),
    ServiceModel(
      title: 'Starter Fish',
      subtitle: 'Peaceful aquarium friends for beginners',
      image: '',
      price: 5000,
    ),
  ],
  'Foods': [
    ServiceModel(
      title: 'Chicken Bites',
      subtitle: 'Protein-rich dry food for daily meals',
      image: '',
      price: 4500,
    ),
    ServiceModel(
      title: 'Salmon Pate',
      subtitle: 'Soft wet food with a smooth texture',
      image: '',
      price: 3800,
    ),
    ServiceModel(
      title: 'Training Treats',
      subtitle: 'Small rewards for lessons and walks',
      image: '',
      price: 2500,
    ),
    ServiceModel(
      title: 'Dental Chews',
      subtitle: 'Crunchy snacks that support clean teeth',
      image: '',
      price: 3200,
    ),
    ServiceModel(
      title: 'Kitten Formula',
      subtitle: 'Balanced nutrition for growing cats',
      image: '',
      price: 6900,
    ),
    ServiceModel(
      title: 'Puppy Blend',
      subtitle: 'Gentle food made for young dogs',
      image: '',
      price: 7200,
    ),
  ],
  'Healthy': [
    ServiceModel(
      title: 'Vitamin Drops',
      subtitle: 'Daily supplement for coat and energy',
      image: '',
      price: 4200,
    ),
    ServiceModel(
      title: 'Calming Spray',
      subtitle: 'Soft scent for travel and grooming days',
      image: '',
      price: 5100,
    ),
    ServiceModel(
      title: 'Paw Balm',
      subtitle: 'Protective care for dry paw pads',
      image: '',
      price: 2900,
    ),
    ServiceModel(
      title: 'Ear Wipes',
      subtitle: 'Gentle cleaning wipes for routine care',
      image: '',
      price: 1900,
    ),
    ServiceModel(
      title: 'First Aid Kit',
      subtitle: 'Compact essentials for small accidents',
      image: '',
      price: 9800,
    ),
    ServiceModel(
      title: 'Flea Shield',
      subtitle: 'Seasonal protection for outdoor pets',
      image: '',
      price: 6200,
    ),
  ],
  'Toys': [
    ServiceModel(
      title: 'Feather Wand',
      subtitle: 'Light teaser toy for active cats',
      image: '',
      price: 1800,
    ),
    ServiceModel(
      title: 'Squeaky Bone',
      subtitle: 'Soft chew toy for playful dogs',
      image: '',
      price: 2400,
    ),
    ServiceModel(
      title: 'Puzzle Ball',
      subtitle: 'Treat toy that keeps pets focused',
      image: '',
      price: 3600,
    ),
    ServiceModel(
      title: 'Rope Ring',
      subtitle: 'Tug toy for strong and safe play',
      image: '',
      price: 2700,
    ),
    ServiceModel(
      title: 'Plush Mouse',
      subtitle: 'Cozy toy for chasing and cuddling',
      image: '',
      price: 2100,
    ),
    ServiceModel(
      title: 'Fetch Disc',
      subtitle: 'Light outdoor toy for quick games',
      image: '',
      price: 3000,
    ),
  ],
  'Accessories': [
    ServiceModel(
      title: 'Soft Collar',
      subtitle: 'Adjustable collar with a gentle fit',
      image: '',
      price: 3500,
    ),
    ServiceModel(
      title: 'Name Tag',
      subtitle: 'Light tag for clear pet identification',
      image: '',
      price: 1500,
    ),
    ServiceModel(
      title: 'Travel Bowl',
      subtitle: 'Foldable bowl for trips and walks',
      image: '',
      price: 2800,
    ),
    ServiceModel(
      title: 'Leash Set',
      subtitle: 'Comfortable handle for daily outings',
      image: '',
      price: 6400,
    ),
    ServiceModel(
      title: 'Grooming Brush',
      subtitle: 'Smooth brush for tidy coats',
      image: '',
      price: 3900,
    ),
    ServiceModel(
      title: 'Carry Bag',
      subtitle: 'Padded carrier for short city travel',
      image: '',
      price: 14500,
    ),
  ],
  'Clothes': [
    ServiceModel(
      title: 'Rain Jacket',
      subtitle: 'Light cover for wet walks',
      image: '',
      price: 8900,
    ),
    ServiceModel(
      title: 'Warm Sweater',
      subtitle: 'Soft knit for chilly mornings',
      image: '',
      price: 7600,
    ),
    ServiceModel(
      title: 'Party Bow',
      subtitle: 'Cute accent for photos and visits',
      image: '',
      price: 1800,
    ),
    ServiceModel(
      title: 'Cozy Hoodie',
      subtitle: 'Relaxed layer for indoor comfort',
      image: '',
      price: 8200,
    ),
    ServiceModel(
      title: 'Bootie Set',
      subtitle: 'Paw covers for clean city walks',
      image: '',
      price: 5400,
    ),
    ServiceModel(
      title: 'Bandana Pack',
      subtitle: 'Colorful everyday style set',
      image: '',
      price: 2600,
    ),
  ],
};

const Map<String, IconData> _categoryIcons = {
  'Pets': Icons.pets_rounded,
  'Foods': Icons.restaurant_rounded,
  'Healthy': Icons.health_and_safety_rounded,
  'Toys': Icons.toys_rounded,
  'Accessories': Icons.local_mall_rounded,
  'Clothes': Icons.checkroom_rounded,
};

const Map<String, List<IconData>> _shopProductIcons = {
  'Pets': [
    Icons.pets_rounded,
    Icons.cruelty_free_rounded,
    Icons.home_rounded,
    Icons.music_note_rounded,
    Icons.nightlight_round,
    Icons.water_rounded,
  ],
  'Foods': [
    Icons.restaurant_rounded,
    Icons.dinner_dining_rounded,
    Icons.cookie_rounded,
    Icons.cleaning_services_rounded,
    Icons.local_drink_rounded,
    Icons.rice_bowl_rounded,
  ],
  'Healthy': [
    Icons.health_and_safety_rounded,
    Icons.spa_rounded,
    Icons.healing_rounded,
    Icons.clean_hands_rounded,
    Icons.medical_services_rounded,
    Icons.shield_rounded,
  ],
  'Toys': [
    Icons.toys_rounded,
    Icons.sports_baseball_rounded,
    Icons.extension_rounded,
    Icons.sports_handball_rounded,
    Icons.smart_toy_rounded,
    Icons.album_rounded,
  ],
  'Accessories': [
    Icons.style_rounded,
    Icons.sell_rounded,
    Icons.rice_bowl_rounded,
    Icons.linear_scale_rounded,
    Icons.brush_rounded,
    Icons.local_mall_rounded,
  ],
  'Clothes': [
    Icons.checkroom_rounded,
    Icons.dry_cleaning_rounded,
    Icons.celebration_rounded,
    Icons.layers_rounded,
    Icons.directions_walk_rounded,
    Icons.auto_awesome_rounded,
  ],
};
