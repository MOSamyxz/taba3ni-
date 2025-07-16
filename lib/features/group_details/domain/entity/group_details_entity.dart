import 'package:taba3ni/features/add_group/domain/entity/add_group_entity.dart';

class GroupDetailsEntity {
  final String id;
  final String name;
  final String? notes;
  final List<ScheduleEntry> schedule;

const GroupDetailsEntity({required this.id, required this.name, required this.notes, required this.schedule});
}