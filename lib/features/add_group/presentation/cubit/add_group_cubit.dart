import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/features/groups/domain/entity/group_entity.dart';
import 'package:taba3ni/features/add_group/domain/usecase/add_group_usecase.dart';
import 'package:uuid/uuid.dart';

part 'add_group_state.dart';

class AddGroupCubit extends Cubit<AddGroupState> {
  final nameController = TextEditingController();
  final notesController = TextEditingController();
  final uuid = Uuid();
  final AddGroupUseCase addGroupUseCase;

  final Map<String, TimeOfDay?> selectedDays = {
    'السبت': null,
    'الأحد': null,
    'الاثنين': null,
    'الثلاثاء': null,
    'الأربعاء': null,
    'الخميس': null,
    'الجمعة': null,
  };

  AddGroupCubit({required this.addGroupUseCase}) : super(AddGroupInitial());

  void pickTime(String day, BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 16, minute: 0),
    );
    if (time != null) {
      selectedDays[day] = time;
      emit(AddGroupUpdated());
    }
  }

  Future<GroupEntity?> submit(BuildContext context) async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      emit(AddGroupError('اسم المجموعة مطلوب'));
      return null;
    }

    final schedule = selectedDays.entries
        .where((entry) => entry.value != null)
        .map((entry) => ScheduleEntry(
              day: entry.key,
              time: entry.value!.format(context),
            ))
        .toList();

    if (schedule.isEmpty) {
      emit(AddGroupError('اختر يوم ووقت واحد على الأقل'));
      return null;
    }

    final group = GroupEntity(
      id: uuid.v4(),
      name: name,
      notes: notesController.text.trim(),
      schedule: schedule,
    );

    emit(AddGroupSubmitted(group));
    return group;
  }

Future<void> addGroup(GroupEntity group) async {
    try {
      log('Group loading'); // تسجيل إضافة المجموعة
      emit(AddGroupLoading());
      await addGroupUseCase(group);
      log('Group added: ${group.name}'); // تسجيل إضافة المجموعة
     } catch (e) {
          log('❌ خطأ أثناء إضافة الجروب: $e');

      emit(AddGroupError('فشل في إضافة المجموعة'));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    notesController.dispose();
    return super.close();
  }
}
