import 'package:flutter/material.dart';

import '../../core/constants/app_routes.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/pet_logo.dart';

class AuthChoiceScreen extends StatelessWidget {
  const AuthChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSizes.screenMaxWidth,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'PetGuardian',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const Center(child: PetLogo(size: 190)),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Choose how you want to continue',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  CustomButton(
                    label: 'Login',
                    icon: Icons.login_rounded,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.login),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  CustomButton(
                    label: 'Register',
                    icon: Icons.person_add_alt_1_rounded,
                    isSecondary: true,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.register),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
