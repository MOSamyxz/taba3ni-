
class GroupEntity {
  final String id;
  final String name;
  final String? notes;
  final List<ScheduleEntry> schedule;
final String grade;
const GroupEntity({required this.id, required this.name, required this.notes, required this.schedule ,required this.grade});
}



class ScheduleEntry {
  final String day;
  final String time;

  ScheduleEntry({required this.day, required this.time});

  Map<String, dynamic> toMap() => {
        'day': day,
        'time': time,
      };

  factory ScheduleEntry.fromMap(Map<String, dynamic> json) {
    return ScheduleEntry(
      day: json['day'],
      time: json['time'],
    );
  }
}
