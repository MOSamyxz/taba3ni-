import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(DateTime date) {
    return DateFormat.yMMMMd('ar').format(date); // مثال: 13 يوليو 2025
  }

  static String formatTime(DateTime date) {
    return DateFormat.Hm().format(date); // 14:30
  }

  static String formatCurrency(num amount) {
    final formatter = NumberFormat.currency(locale: 'ar_EG', symbol: 'ج.م');
    return formatter.format(amount);
  }
}
