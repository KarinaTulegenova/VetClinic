import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/appointment_model.dart';

class AppointmentService {
  AppointmentService._();

  static const String _storageKey = 'petguardian_appointments';
  static final List<AppointmentModel> _appointments = [];
  static bool _loaded = false;

  static List<AppointmentModel> get appointments =>
      List.unmodifiable(_appointments);

  static Future<List<AppointmentModel>> load() async {
    if (_loaded) {
      return appointments;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = prefs.getStringList(_storageKey) ?? const [];
      _appointments
        ..clear()
        ..addAll(
          encoded.map((entry) {
            return AppointmentModel.fromJson(
              jsonDecode(entry) as Map<String, dynamic>,
            );
          }),
        );
    } catch (_) {
      _appointments.clear();
    }
    _loaded = true;
    return appointments;
  }

  static Future<void> add(AppointmentModel appointment) async {
    if (!_loaded) {
      await load();
    }
    _appointments.insert(0, appointment);
    await _save();
  }

  static Future<void> removeAt(int index) async {
    await load();
    if (index < 0 || index >= _appointments.length) {
      return;
    }
    _appointments.removeAt(index);
    await _save();
  }

  static Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        _storageKey,
        _appointments.map((item) => jsonEncode(item.toJson())).toList(),
      );
    } catch (_) {
      // Keep the in-memory appointment so the current session still works.
    }
  }
}
