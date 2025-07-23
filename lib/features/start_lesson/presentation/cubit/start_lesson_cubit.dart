import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:taba3ni/features/student_shared/domain/entity/student_entity.dart';
import 'package:uuid/uuid.dart';
import '../../../lesson_shared/domain/entity/lesson_entity.dart';
import '../../domain/entity/attendance_entity.dart';
import '../../domain/usecase/create_lesson_usecase.dart';
import '../../domain/usecase/record_attendance_usecase.dart';

part 'start_lesson_state.dart';

class StartLessonCubit extends Cubit<StartLessonState> {
  final CreateLessonUseCase createLesson;
  final RecordAttendanceUseCase recordAttendance;
 final topicController = TextEditingController();
  final Map<String, String> attendanceMap = {}; // studentId -> status

  StartLessonCubit({
    required this.createLesson,
    required this.recordAttendance,
  }) : super(StartLessonInitial());

  Future<void> startLesson(
      LessonEntity lesson, List<AttendanceEntity> attendance) async {
    emit(StartLessonLoading());
    try {
      await createLesson(lesson);
      await recordAttendance(attendance);
      emit(StartLessonSuccess());
    } catch (e) {
      log( '🔥 CUBIT EMITTING ERROR: $e');
      emit(StartLessonError('فشل بدء الحصة : ${e.toString()}'));
    }
  }
void setAttendance(id,value){
  attendanceMap[id] = value;
  emit(SetAttenddance(studentId: id, status: value));
}
 void submit({
  required String groupId,
  required List<StudentsEntity> students,
}) {
  final now = DateTime.now();
  final lessonId = const Uuid().v4();

  final lesson = LessonEntity(
    id: lessonId,
    groupId: groupId,
    date: now,
    isExtre: false,
    topic: topicController.text.trim().isEmpty
        ? null
        : topicController.text.trim(),
  );

  final attendanceList = students.map((student) {

    final present = attendanceMap[student.id] == 'present';
    return AttendanceEntity(
      id: const Uuid().v4(),
      lessonId: lessonId,
      studentId: student.id,
      present: present,
      reason: null,
    );
  }).toList();

  startLesson(lesson, attendanceList);
}

}
