import 'dart:convert';

import 'package:taba3ni/features/add_group/domain/entity/add_group_entity.dart';
import 'package:taba3ni/features/group_details/domain/entity/group_details_entity.dart';

class GroupDetailsModel extends GroupDetailsEntity {
  const GroupDetailsModel({
    required super.id,
    required super.name,
    super.notes,
    required super.schedule,
  });

  factory GroupDetailsModel.fromMap(Map<String, dynamic> map) {
 
  final scheduleList = (map['schedule'] as List)
      .map((e) => ScheduleEntry(day: e['day'], time: e['time']))
      .toList();
    return GroupDetailsModel(
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
      'schedule': jsonEncode(schedule.map((e) => {'day': e.day, 'time': e.time}).toList()),
    };
  }
}

