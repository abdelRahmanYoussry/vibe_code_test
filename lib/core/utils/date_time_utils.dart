import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/utils/safe_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'data_utils.dart';

String formatDuration(Duration duration) {
  String negativeSign = duration.isNegative ? '-' : '';
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
  return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

Duration parseDuration(String duration) {
  final parts = duration.safeSplit(':');
  return Duration(
    hours: int.tryParse(parts.safeElementAt(0) ?? '') ?? 0,
    minutes: int.tryParse(parts.safeElementAt(1) ?? '') ?? 0,
    seconds: int.tryParse(parts.safeElementAt(2) ?? '') ?? 0,
  );
}

DateTime? parseDateTime(String src) {
  try {
    if (!validString(src.trim())) {
      return null;
    }
    final srcInt = int.tryParse(src);
    if (srcInt != null) {
      return DateTime.fromMillisecondsSinceEpoch(srcInt);
    }
    return DateTime.tryParse(src) ?? DateFormat('dd/MM/yyyy').parse(src);
  } catch (e) {
    return null;
  }
}


String formatDateTimeWithTime(DateTime dateTime) {
  // Format: July 31, 2025 - 1:24 PM
  final months = ['January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',];

  final month = months[dateTime.month - 1];
  final day = dateTime.day;
  final year = dateTime.year;

  // Convert 24-hour format to 12-hour format with AM/PM
  int hour = dateTime.hour;
  final String period = hour >= 12 ? 'PM' : 'AM';
  hour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour); // Convert 0 to 12 for 12 AM
  final minute = dateTime.minute.toString().padLeft(2, '0');

  return '$month $day, $year - $hour:$minute $period';
}

String getDayLocalKey(int day, BuildContext context) {
  switch (day) {
    case DateTime.saturday:
      return Loc.of(context).saturday;
    case DateTime.sunday:
      return Loc.of(context).sunday;
    case DateTime.monday:
      return Loc.of(context).monday;
    case DateTime.tuesday:
      return Loc.of(context).tuesday;
    case DateTime.wednesday:
      return Loc.of(context).wednesday;
    case DateTime.thursday:
      return Loc.of(context).thursday;
    case DateTime.friday:
      return Loc.of(context).friday;
  }
  return '';
}

class DateDifference {
  final int years;
  final int months;
  final int days;

  DateDifference({required this.years, required this.months, required this.days});
}

DateDifference calculateDateDifference(DateTime startDate, DateTime endDate) {
  int years = endDate.year - startDate.year;
  int months = endDate.month - startDate.month;
  int days = endDate.day - startDate.day;

  // Adjust for negative months and days
  if (days < 0) {
    months -= 1;
    days += DateTime(endDate.year, endDate.month, 0).day; // Gets the last day of the previous month
  }
  if (months < 0) {
    years -= 1;
    months += 12;
  }

  return DateDifference(years: years, months: months, days: days);
}

int getWeekFromDay(int day) => switch (day) {
      > 0 && <= 7 => 1,
      > 7 && <= 14 => 2,
      > 14 && <= 21 => 3,
      > 21 && <= 31 => 4,
      _ => 0,
    };

DateTime getFirstDateOfWeek(DateTime date) {
  final week = getWeekFromDay(date.day);
  return DateTime(
    date.year,
    date.month,
    (week - 1) * 7 + 1,
  );
}

DateTime getLastDateOfWeek(DateTime date) {
  final week = getWeekFromDay(date.day);
  return week == 4
      ? getLastDateOfMonth(date)
      : DateTime(
          date.year,
          date.month,
          week * 7,
        );
}

DateTime getFirstDateOfMonth(DateTime date) {
  return DateTime(
    date.year,
    date.month,
    1,
  );
}

DateTime getLastDateOfMonth(DateTime date) {
  return DateTime(
    date.year,
    date.month + 1,
    1,
  ).subtract(const Duration(days: 1));
}

DateTime getFirstDateOfYear(DateTime date) {
  return DateTime(
    date.year,
    1,
    1,
  );
}

DateTime getLastDateOfYear(DateTime date) {
  return DateTime(
    date.year + 1,
    1,
    1,
  ).subtract(const Duration(days: 1));
}

int calculateDifferenceWithWeekendDays(DateTime startDate, DateTime endDate) {
  if (endDate.isBefore(startDate)) {
    return 0;
  }

  int totalDays = 0;

  for (DateTime current = startDate; !current.isAfter(endDate); current = current.add(const Duration(days: 1))) {
    totalDays++;
  }

  return totalDays;
}

int calculateDifferenceWithoutWeekendDays(DateTime startDate, DateTime endDate) {
  if (endDate.isBefore(startDate)) {
    return 0;
  }

  int totalDays = 0;

  for (DateTime current = startDate; !current.isAfter(endDate); current = current.add(const Duration(days: 1))) {
    // Check if the current day is not a weekend (Saturday or Sunday)
    if (current.weekday != DateTime.friday && current.weekday != DateTime.saturday) {
      totalDays++;
    }
  }

  return totalDays;
}

DateTime durationToDateTime(Duration duration) => DateTime(0).add(duration);

Duration parseRemainingTime(String remaining) {
  // Handle empty or null case
  if (remaining.isEmpty) {
    return Duration.zero;
  }

  int hours = 0;
  int minutes = 0;

  // Split by space to get parts like ["1h", "28m"]
  final parts = remaining.split(' ');

  for (final part in parts) {
    if (part.contains('h')) {
      hours = int.tryParse(part.replaceAll('h', '')) ?? 0;
    } else if (part.contains('m')) {
      minutes = int.tryParse(part.replaceAll('m', '')) ?? 0;
    }
  }

  return Duration(hours: hours, minutes: minutes);
}
