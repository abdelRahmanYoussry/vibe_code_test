import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

class ShortFuzzyTimeFormat implements LookupMessages {
  final BuildContext context;

  ShortFuzzyTimeFormat({
    required this.context,
  });

  @override
  String aboutAMinute(int minutes) => this.minutes(minutes);

  @override
  String aboutAnHour(int minutes) => hours(minutes ~/ 60);

  @override
  String aDay(int hours) => days(hours ~/ 24);

  @override
  String aboutAMonth(int days) => months(days ~/ 30);

  @override
  String aboutAYear(int year) => years(year);

  @override
  String lessThanOneMinute(int seconds) => Loc.of(context).secsAgo(seconds);

  @override
  String minutes(int minutes) => Loc.of(context).minsAgo(minutes);

  @override
  String hours(int hours) => Loc.of(context).hoursAgo(hours);

  @override
  String days(int days) => Loc.of(context).daysAgo(days);

  @override
  String months(int months) => Loc.of(context).monthsAgo(months);

  @override
  String years(int years) => Loc.of(context).yearsAgo(years);

  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String wordSeparator() => '';
}
