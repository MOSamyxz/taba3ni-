import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/core/utils/arabic_to%20_english_number.dart';
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

  final ValueNotifier<Map<String, TimeOfDay?>> selectedDays = ValueNotifier({});

  String? selectedGradeArabic;
  String? selectedGradeEnglish; // القيمة اللي هتتبعت لـ Supabase
  final Map<String, String> gradeOptionsMap = {
    'ابتدائي': 'primary',
    'إعدادي': 'middle',
    'ثانوي': 'high',
  };
  bool isEditMode = false;
  String? editingGroupId;

  AddGroupCubit({
    required this.addGroupUseCase,
    required this.updateGroupUseCase,
  }) : super(AddGroupInitial());

  void initialize(GroupEntity? group) {
    if (group != null) {
      nameController.text = group.name;
      notesController.text = group.notes ?? '';
      selectedGradeArabic =
          gradeOptionsMap.entries
              .firstWhere(
                (entry) => entry.value == group.grade,
                orElse: () => const MapEntry('غير معروف', 'Unknown'),
              )
              .key;

      final newDays = <String, TimeOfDay?>{};
      for (var entry in group.schedule) {
        final arabicDay = Utils.getArabicDay(entry.day);
        newDays[arabicDay] = Utils.parseTimeOfDay(entry.time);
      }

      selectedDays.value = newDays;
      isEditMode = true;
      editingGroupId = group.id;
    } else {
      isEditMode = false;
    }
  }


  void pickTime(String day, BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 16, minute: 0),
      barrierColor: Colors.black54,
    );
    if (time != null) {
      final newMap = Map<String, TimeOfDay?>.from(selectedDays.value);
      newMap[day] = time;
      selectedDays.value = newMap;
      emit(AddGroupUpdated());
    }
  }

  void showDayPicker(BuildContext context) {
    final availableArabicDays =
        Utils.allDaysArabic
            .where((arabicDay) => !selectedDays.value.containsKey(arabicDay))
            .toList();

    showModalBottomSheet(
      context: context,
      builder:
          (_) => ListView(
            children:
                availableArabicDays.map((arabicDay) {
                  return ListTile(
                    title: Text(arabicDay),
                    onTap: () {
                      final newMap = Map<String, TimeOfDay?>.from(
                        selectedDays.value,
                      );
                      newMap[arabicDay] = null;
                      selectedDays.value = newMap;
                      Navigator.pop(context);
                      emit(AddGroupUpdated());
                    },
                  );
                }).toList(),
          ),
    );
  }

  void removeDay(String day) {
    selectedDays.value.remove(day);
    selectedDays.value = Map.from(selectedDays.value);
    emit(AddGroupUpdated());
  }

  String _formatTimeToEnglish(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute'; // Always in English format
  }

  Future<GroupEntity?> submit(
    BuildContext context,
    GroupEntity? currentGroup,
  ) async {
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

    final schedule =
        selectedDays.value.entries
            .where((entry) => entry.value != null)
            .map(
              (entry) => ScheduleEntry(
                day: Utils.getEnglishDay(entry.key),
                time: _formatTimeToEnglish(entry.value!),
              ),
            )
            .toList();

    if (schedule.isEmpty) {
      emit(AddGroupError('اختر يوم ووقت واحد على الأقل'));
      return null;
    }
    selectedGradeEnglish ??= currentGroup?.grade;
    final group = GroupEntity(
      id: isEditMode ? editingGroupId! : uuid.v4(),
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
      await updateGroupUseCase(group);
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
