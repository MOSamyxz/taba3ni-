import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/features/add_group/domain/usecase/add_group_usecase.dart';
import 'package:taba3ni/features/add_group/domain/usecase/update_group_usecase.dart';
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';
import 'package:uuid/uuid.dart';

part 'add_group_state.dart';

class AddGroupCubit extends Cubit<AddGroupState> {
  final nameController = TextEditingController();
  final notesController = TextEditingController();
  final uuid = Uuid();
  final AddGroupUseCase addGroupUseCase;
  final UpdateGroupUseCase updateGroupUseCase;

  final Map<String, TimeOfDay?> selectedDays = {
    'السبت': null,
    'الأحد': null,
    'الاثنين': null,
    'الثلاثاء': null,
    'الأربعاء': null,
    'الخميس': null,
    'الجمعة': null,
  };
String? selectedGradeArabic;
String? selectedGradeEnglish; // القيمة اللي هتتبعت لـ Supabase
  final Map<String, String> gradeOptionsMap = {
  'ابتدائي': 'primary',
  'إعدادي': 'middle',
  'ثانوي': 'high',
};
bool isEditMode = false;
String? editingGroupId;


  AddGroupCubit({required this.addGroupUseCase , required this.updateGroupUseCase}) : super(AddGroupInitial());

void initialize(GroupEntity? group) {
  if (group != null) {
    nameController.text = group.name;
    notesController.text = group.notes??'';
    selectedGradeArabic = gradeOptionsMap.entries.firstWhere(
      (entry) => entry.value == group.grade,
      orElse: () => const MapEntry('غير معروف', 'Unknown'),
    ).key;

    // الأيام والمواعيد
for (var entry in group.schedule) {
  selectedDays[entry.day] = _parseTimeOfDay(entry.time);
}

    isEditMode = true;
    editingGroupId = group.id;
  } else {
    isEditMode = false;
  }
}
TimeOfDay _parseTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

  void pickTime(String day, BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 16, minute: 0),
      barrierColor:  Colors.black54,
    );
    if (time != null) {
      selectedDays[day] = time;
      emit(AddGroupUpdated());
    }
  }

Future<GroupEntity?> submit(BuildContext context) async {
  final name = nameController.text.trim();
  final notes = notesController.text.trim();

  if (name.isEmpty) {
    emit(AddGroupError('اسم المجموعة مطلوب'));
    return null;
  }
  if (notes.isEmpty) {
    emit(AddGroupError('الملاحظات مطلوبة'));
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
    id: isEditMode ? editingGroupId! : uuid.v4(), // 👈 الفرق هنا
    name: name,
    notes: notes,
    schedule: schedule,
    grade: selectedGradeEnglish ?? '',
  );

  emit(GroupSubmitted(group));
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

  Future<void> updateGroup(GroupEntity group) async {
  try {
    log('Updating group...');
    emit(UpdateGroupLoading());
    await addGroupUseCase(group);  
    log('Group updated: ${group.name}');
  } catch (e) {
    log('❌ فشل في تحديث الجروب: $e');
    emit(UpdateGroupError('فشل في تحديث المجموعة'));
  }
}

  @override
  Future<void> close() {
    nameController.dispose();
    notesController.dispose();
    return super.close();
  }

}
