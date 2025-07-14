class TimeService {
  DateTime now() => DateTime.now();

  String format(DateTime date) {
    // تقدر تربطه بـ Formatter
    return date.toIso8601String();
  }
}
