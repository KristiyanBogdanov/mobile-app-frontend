import 'package:intl/intl.dart';

extension StringExtensions on String {
  String parseWithDateFormat(String format) {
    final dateTime = DateTime.parse(this);
    final dateFormat = DateFormat(format);

    return dateFormat.format(dateTime);
  }
}