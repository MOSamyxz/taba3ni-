import 'package:taba3ni/features/attendance_stats/domain/entity/student_attendance_stats_entity.dart';

class StudentAttendanceStatsModel extends StudentAttendanceStatsEntity {
  StudentAttendanceStatsModel({
    required super.studentId,
    required super.studentName,
    required super.presentCount,
    required super.absentCount,
  });

  factory StudentAttendanceStatsModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceStatsModel(
      studentId: json['studentId'],
      studentName: json['studentName'],
      presentCount: json['presentCount'],
      absentCount: json['absentCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'presentCount': presentCount,
      'absentCount': absentCount,
    };
  }


  StudentAttendanceStatsModel copyWith({
    int? presentCount,
    int? absentCount,
  }) {
    return StudentAttendanceStatsModel(
      studentId: studentId,
      studentName: studentName,
      presentCount: presentCount ?? this.presentCount,
      absentCount: absentCount ?? this.absentCount,
    );
  }
}
