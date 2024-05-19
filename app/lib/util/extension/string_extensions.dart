import 'package:app/shared/constant/index.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  String parseWithDateFormat(String format) {
    final dateTime = DateTime.parse(this);
    final dateFormat = DateFormat(format);

    return dateFormat.format(dateTime);
  }
  
  String get parseTimestamp {
    final now = DateTime.now();
    final notificationTime = DateTime.parse(this);
    final difference = now.difference(notificationTime);

    if (difference.inDays > 0) {
      return AppStrings.daysAgo(difference.inDays);
    } else if (difference.inHours > 0) {
      return AppStrings.hoursAgo(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return AppStrings.minutesAgo(difference.inMinutes);
    } else {
      return AppStrings.justNow;
    }
  }
}