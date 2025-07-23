
class AttendanceEntity {
  final String id;
  final String lessonId;
  final String studentId;
  final bool present;  
  final String? reason;

  AttendanceEntity({
    required this.id,
    required this.lessonId,
    required this.studentId,
    required this.present,
    this.reason,
  });
}

 