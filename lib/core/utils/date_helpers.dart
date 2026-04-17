import 'package:intl/intl.dart';

class DateHelpers {
  DateHelpers._();

  static final DateFormat _display = DateFormat('dd MMM yyyy');
  static final DateFormat _short   = DateFormat('dd MMM');
  static final DateFormat _monthYear = DateFormat('MMMM yyyy');
  static final DateFormat _time   = DateFormat('hh:mm a');

  static String displayDate(DateTime dt) => _display.format(dt);
  static String shortDate(DateTime dt)   => _short.format(dt);
  static String monthYear(DateTime dt)   => _monthYear.format(dt);
  static String timeOf(DateTime dt)      => _time.format(dt);

  static String relativeDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return shortDate(dt);
  }

  static bool isSameMonth(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month;
}
