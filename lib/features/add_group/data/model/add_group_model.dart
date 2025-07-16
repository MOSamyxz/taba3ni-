

import 'package:taba3ni/features/add_group/domain/entity/add_group_entity.dart';

class AddGroupModel extends AddGroupEntity {
  const AddGroupModel({
    required super.id,
    required super.name,
    required super.schedule,
    super.notes,
  });

 factory AddGroupModel.fromMap(Map<String, dynamic> map) {
  final scheduleList = (map['schedule'] as List)
      .map((e) => ScheduleEntry(day: e['day'], time: e['time']))
      .toList();

  return AddGroupModel(
    id: map['id'],
    name: map['name'],
    notes: map['notes'],
    schedule: scheduleList,
  );
}


 Map<String, dynamic> toMap() {
  return {
    'id': id,
    'name': name,
    'notes': notes,
    'schedule': schedule.map((e) => {
      'day': e.day,
      'time': e.time,
    }).toList(),
  };
}

}
