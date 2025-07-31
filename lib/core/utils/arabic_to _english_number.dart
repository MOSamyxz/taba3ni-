import 'package:flutter/material.dart';


class Utils {

 static TimeOfDay parseTimeString(String timeString) {
  final parts = timeString.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}



static String arabicToEnglishNumbers(String input) {
  const arabic = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];
  const english = ['0','1','2','3','4','5','6','7','8','9'];

  for (int i = 0; i < arabic.length; i++) {
    input = input.replaceAll(arabic[i], english[i]);
  }

  return input;
}

//* Day utils
static Map<String, String> allDaysMap = {
  'Saturday': 'السبت',
  'Sunday': 'الأحد',
  'Monday': 'الاثنين',
  'Tuesday': 'الثلاثاء',
  'Wednesday': 'الأربعاء',
  'Thursday': 'الخميس',
  'Friday': 'الجمعة',
};
static List<String> englishDays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

static List<String> get allDaysArabic => allDaysMap.values.toList();

static String getEnglishDay(String arabicDay) =>
    allDaysMap.entries.firstWhere((e) => e.value == arabicDay).key;

static String getArabicDay(String englishDay) =>
    allDaysMap[englishDay] ?? englishDay;

static   TimeOfDay  parseTimeOfDay(String timeString) {
    final formatted = Utils.arabicToEnglishNumbers(timeString.trim());

    final timeParts = formatted.split(RegExp(r'[:\s]'));

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    final isPm = formatted.contains('PM') || formatted.contains('م');
    final isAm = formatted.contains('AM') || formatted.contains('ص');

    if (isPm && hour < 12) hour += 12;
    if (isAm && hour == 12) hour = 0;

    return TimeOfDay(hour: hour, minute: minute);
  }
}