import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'screens/activity/activity_log_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/grooming/grooming_screen.dart';
import 'screens/login/auth_choice_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/login/register_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/search/animal_detail_screen.dart';
import 'screens/search/search_result_screen.dart';
import 'screens/shop/cart_screen.dart';
import 'screens/shop/shop_category_screen.dart';
import 'screens/shop/shop_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/training/training_screen.dart';
import 'screens/shared/category_list_screen.dart';
import 'screens/shared/map_screen.dart';
import 'screens/shared/service_list_screen.dart';
import 'screens/veterinary/doctor_detail_screen.dart';
import 'screens/veterinary/appointments_screen.dart';
import 'screens/veterinary/veterinary_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const PetGuardianApp());
}

class PetGuardianApp extends StatelessWidget {
  const PetGuardianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetGuardian',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.authChoice: (_) => const AuthChoiceScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),
        AppRoutes.dashboard: (_) => const DashboardScreen(),
        AppRoutes.veterinary: (_) => const VeterinaryScreen(),
        AppRoutes.doctorDetail: (_) => const DoctorDetailScreen(),
        AppRoutes.appointments: (_) => const AppointmentsScreen(),
        AppRoutes.grooming: (_) => const GroomingScreen(),
        AppRoutes.shop: (_) => const ShopScreen(),
        AppRoutes.shopCategory: (_) => const ShopCategoryScreen(),
        AppRoutes.cart: (_) => const CartScreen(),
        AppRoutes.training: (_) => const TrainingScreen(),
        AppRoutes.activityLog: (_) => const ActivityLogScreen(),
        AppRoutes.profile: (_) => const ProfileScreen(),
        AppRoutes.profileDetails: (_) => const ProfileDetailsScreen(),
        AppRoutes.notificationSettings: (_) =>
            const NotificationSettingsScreen(),
        AppRoutes.privacy: (_) => const PrivacyScreen(),
        AppRoutes.map: (_) => const MapScreen(),
        AppRoutes.searchResults: (_) => const SearchResultScreen(),
        AppRoutes.animalDetail: (_) => const AnimalDetailScreen(),
        AppRoutes.categoryList: (_) => const CategoryListScreen(),
        AppRoutes.serviceList: (_) => const ServiceListScreen(),
      },
    );
  }
}
