import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isAfterOrEqualTo(DateTime anotherDateTime) {
    return isSameDate(anotherDateTime) || isAfter(anotherDateTime);
  }

  bool isBeforeOrEqualTo(DateTime anotherDateTime) {
    return isSameDate(anotherDateTime) || isBefore(anotherDateTime);
  }

  String get toDisplay {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(this);
  }
}
