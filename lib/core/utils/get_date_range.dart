import 'dart:core';

import 'dart:core';

String formatDate(DateTime dateTime) {
  return '${dateTime.year}-${_addLeadingZero(dateTime.month)}-${_addLeadingZero(dateTime.day)} ${_addLeadingZero(dateTime.hour)}:${_addLeadingZero(dateTime.minute)}:${_addLeadingZero(dateTime.second)}';
}

String _addLeadingZero(int number) {
  return number.toString().padLeft(2, '0');
}

String getDateRange(String timeFrame) {
  DateTime now = DateTime.now();
  DateTime start;
  DateTime end;

  switch (timeFrame) {
    case 'day':
      start = DateTime(now.year, now.month, now.day, 8, 0, 0);
      end = DateTime(now.year, now.month, now.day, 23, 59, 59);
      break;
    case 'week':
      start = now.subtract(Duration(days: now.weekday - 1));
      end = start.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
      break;
    case 'month':
      start = DateTime(now.year, now.month, 1, 0, 0, 0);
      end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
      break;
    default:
      return 'Invalid time frame';
  }

  return '${formatDate(start)}/${formatDate(end)}';
}
