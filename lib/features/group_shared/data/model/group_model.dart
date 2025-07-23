
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';

class GroupModel extends GroupEntity {
  const GroupModel({
    required super.id,
    required super.name,
    super.notes,
    required super.schedule,
    required super.grade,
  });

  factory GroupModel.fromMap(Map<String, dynamic> map) {
 
  final scheduleList = (map['schedule'] as List)
      .map((e) => ScheduleEntry(day: e['day'], time: e['time']))
      .toList();
    return GroupModel(
      id: map['id'],
      name: map['name'],
      notes: map['notes'],
      schedule: scheduleList,
      grade: map['grade'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'notes': notes,
    'schedule': schedule.map((e) => {'day': e.day, 'time': e.time}).toList(),
      'grade': grade
    };
  }
}

