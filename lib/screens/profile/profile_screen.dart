import 'package:flutter/material.dart';

import '../../core/constants/app_routes.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/navigation_utils.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
        title: const Text('Profile'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.screenMaxWidth),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              FutureBuilder<UserModel?>(
                future: AuthService.loadCurrentUser(),
                builder: (context, snapshot) {
                  final user =
                      snapshot.data ??
                      const UserModel(
                        name: 'Guest',
                        email: 'Create an account to save your profile',
                      );
                  return Column(
                    children: [
                      Center(
                        child: Container(
                          width: 116,
                          height: 116,
                          decoration: const BoxDecoration(
                            color: AppColors.primarySoft,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person_outline_rounded,
                            color: AppColors.primary,
                            size: 58,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        user.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        user.email,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              CustomCard(
                child: Column(
                  children: [
                    _ProfileAction(
                      icon: Icons.person_outline_rounded,
                      label: 'Account details',
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.profileDetails,
                      ),
                    ),
                    const Divider(),
                    _ProfileAction(
                      icon: Icons.notifications_none_rounded,
                      label: 'Notification settings',
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.notificationSettings,
                      ),
                    ),
                    const Divider(),
                    _ProfileAction(
                      icon: Icons.privacy_tip_outlined,
                      label: 'Privacy and security',
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.privacy),
                    ),
                    const Divider(),
                    _ProfileAction(
                      icon: Icons.logout_rounded,
                      label: 'Logout',
                      onTap: () async {
                        await AuthService.logout();
                        if (context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.authChoice,
                            (_) => false,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileAction extends StatelessWidget {
  const _ProfileAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
      onTap: onTap,
    );
  }
}

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: AuthService.loadCurrentUser(),
      builder: (context, snapshot) {
        final user =
            snapshot.data ??
            const UserModel(name: 'Guest', email: 'No saved account');
        return _ProfileSubScreen(
          title: 'Account Details',
          icon: Icons.person_outline_rounded,
          children: [
            _InfoRow(label: 'Name', value: user.name),
            const Divider(),
            _InfoRow(label: 'Email', value: user.email),
            const Divider(),
            const _InfoRow(label: 'Membership', value: 'PetGuardian Standard'),
          ],
        );
      },
    );
  }
}

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _appointments = true;
  bool _activity = true;
  bool _offers = false;

  @override
  Widget build(BuildContext context) {
    return _ProfileSubScreen(
      title: 'Notification Settings',
      icon: Icons.notifications_none_rounded,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Appointment reminders'),
          value: _appointments,
          activeThumbColor: AppColors.primary,
          onChanged: (value) => setState(() => _appointments = value),
        ),
        const Divider(),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Activity log updates'),
          value: _activity,
          activeThumbColor: AppColors.primary,
          onChanged: (value) => setState(() => _activity = value),
        ),
        const Divider(),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Shop offers'),
          value: _offers,
          activeThumbColor: AppColors.primary,
          onChanged: (value) => setState(() => _offers = value),
        ),
      ],
    );
  }
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileSubScreen(
      title: 'Privacy',
      icon: Icons.privacy_tip_outlined,
      children: [
        _InfoRow(
          label: 'Data use',
          value:
              'PetGuardian stores profile and activity data for app features.',
        ),
        Divider(),
        _InfoRow(
          label: 'Security',
          value:
              'Personal information is represented with mock data in this academic build.',
        ),
        Divider(),
        _InfoRow(
          label: 'Control',
          value:
              'Users can review account and notification settings from Profile.',
        ),
      ],
    );
  }
}

class _ProfileSubScreen extends StatelessWidget {
  const _ProfileSubScreen({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

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
        title: Text(title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.screenMaxWidth),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, color: AppColors.primary, size: 36),
                    const SizedBox(height: AppSpacing.lg),
                    ...children,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
