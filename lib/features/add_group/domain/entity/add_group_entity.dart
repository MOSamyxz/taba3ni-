class AddGroupEntity {
  final String id;
  final String name;
  final String? notes;
  final List<ScheduleEntry> schedule; // أيام ومواعيد الحصص

  const AddGroupEntity({
    required this.id,
    required this.name,
    required this.schedule,
    this.notes,
  });
}



class ScheduleEntry {
  final String day;
  final String time;

  ScheduleEntry({required this.day, required this.time});

  Map<String, dynamic> toJson() => {
        'day': day,
        'time': time,
      };

  factory ScheduleEntry.fromJson(Map<String, dynamic> json) {
    return ScheduleEntry(
      day: json['day'],
      time: json['time'],
    );
  }
}
