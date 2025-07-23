class StudentAttendanceStatsEntity {
  final String studentId;
  final String studentName;
  final int presentCount;
  final int absentCount;

  StudentAttendanceStatsEntity({
    required this.studentId,
    required this.studentName,
    required this.presentCount,
    required this.absentCount,
  });
}
