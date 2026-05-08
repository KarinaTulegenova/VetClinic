import '../models/activity_log_model.dart';

class ActivityLogService {
  ActivityLogService._();

  static final List<ActivityLog> _logs = <ActivityLog>[
    ActivityLog(action: 'Opened PetGuardian app', time: DateTime.now()),
  ];

  static void add(String action) {
    _logs.insert(0, ActivityLog(action: action, time: DateTime.now()));
  }

  static List<ActivityLog> get logs => List.unmodifiable(_logs);

  static Map<String, List<ActivityLog>> groupedLogs() {
    final grouped = <String, List<ActivityLog>>{};
    for (final log in _logs) {
      final label = _dateLabel(log.time);
      grouped.putIfAbsent(label, () => <ActivityLog>[]).add(log);
    }
    return grouped;
  }

  static String _dateLabel(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    }

    const months = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${date.day} ${months[date.month - 1]}';
  }
}
