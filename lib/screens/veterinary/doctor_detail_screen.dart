import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_routes.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/navigation_utils.dart';
import '../../models/appointment_model.dart';
import '../../models/doctor_model.dart';
import '../../services/appointment_service.dart';
import '../../services/activity_log_service.dart';
import '../../services/pet_data_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({super.key});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  int _selectedDayIndex = 2;
  int _selectedTimeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final doctor = _doctorFromArgs(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => NavigationUtils.backOrDashboard(context),
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        title: const Text('Veterinary'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: Image.asset(
                  doctor.image,
                  fit: BoxFit.contain,
                  cacheWidth: 900,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppRadius.xl),
                ),
              ),
              child: ListView(
                children: [
                  Text(
                    doctor.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    doctor.specialty,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: _MetricCard(
                          label: 'Experience',
                          value: doctor.experience,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _MetricCard(label: 'Price', value: doctor.price),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _MetricCard(
                          label: 'Location',
                          value: doctor.distance,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _aboutFor(doctor),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.muted,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _ChoiceSection(
                    title: 'Available Days',
                    values: const [
                      'Fri, 6',
                      'Sat, 7',
                      'Sun, 8',
                      'Mon, 9',
                      'Tue, 10',
                    ],
                    selectedIndex: _selectedDayIndex,
                    onSelected: (index) =>
                        setState(() => _selectedDayIndex = index),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _ChoiceSection(
                    title: 'Available Time',
                    values: const ['09.00', '15.00', '19.00'],
                    selectedIndex: _selectedTimeIndex,
                    onSelected: (index) =>
                        setState(() => _selectedTimeIndex = index),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  CustomButton(
                    label: 'See Location',
                    icon: Icons.map_outlined,
                    isSecondary: true,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.map),
                    height: 42,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  CustomButton(
                    label: 'Book Now',
                    onPressed: () async {
                      const days = [
                        'Fri, 6',
                        'Sat, 7',
                        'Sun, 8',
                        'Mon, 9',
                        'Tue, 10',
                      ];
                      const times = ['09.00', '15.00', '19.00'];
                      await AppointmentService.add(
                        AppointmentModel(
                          doctorName: doctor.name,
                          specialty: doctor.specialty,
                          image: doctor.image,
                          day: days[_selectedDayIndex],
                          time: times[_selectedTimeIndex],
                          price: doctor.price,
                        ),
                      );
                      if (!context.mounted) {
                        return;
                      }
                      ActivityLogService.add(
                        'Selected appointment time ${days[_selectedDayIndex]} at ${times[_selectedTimeIndex]}',
                      );
                      _showMessage(context, 'Appointment booked');
                      Navigator.pushNamed(context, AppRoutes.appointments);
                    },
                    height: 42,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  DoctorModel _doctorFromArgs(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is DoctorModel) {
      return args;
    }
    return PetDataService.doctors.first;
  }

  String _aboutFor(DoctorModel doctor) {
    return '${doctor.name} is a highly experienced ${doctor.specialty.toLowerCase()} specialist with ${doctor.experience} of dedicated practice, delivering gentle care and clear treatment plans for every pet family.';
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChoiceSection extends StatelessWidget {
  const _ChoiceSection({
    required this.title,
    required this.values,
    required this.selectedIndex,
    required this.onSelected,
  });

  final String title;
  final List<String> values;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: List.generate(values.length, (index) {
            final selected = index == selectedIndex;
            return ChoiceChip(
              label: Text(values[index]),
              selected: selected,
              onSelected: (_) => onSelected(index),
              selectedColor: AppColors.primary,
              backgroundColor: Colors.white,
              labelStyle: GoogleFonts.poppins(
                color: selected ? Colors.white : AppColors.text,
              ),
              side: const BorderSide(color: AppColors.primary),
            );
          }),
        ),
      ],
    );
  }
}
