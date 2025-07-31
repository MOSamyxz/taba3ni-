import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:taba3ni/features/add_student/domain/usecase/add_student_usecase.dart';
import 'package:taba3ni/features/payment/domain/entity/payment_entity.dart';
import 'package:taba3ni/features/payment/domain/usecase/add_payment_usecase.dart';
import 'package:taba3ni/features/student_shared/domain/entity/student_entity.dart';
import 'package:uuid/uuid.dart';

part 'add_student_state.dart';

class AddStudentCubit extends Cubit<AddStudentState> {
  final AddStudentUseCase usecase;
  final AddPaymentUseCase addPaymentUseCase;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final parentPhoneController = TextEditingController();
  AddStudentCubit({required this.usecase, required this.addPaymentUseCase})
    : super(AddStudentInitial());

  Future<void> addStudent(StudentsEntity student) async {
    try {
      emit(AddStudentLoading());
      await usecase(student);
     await addStudentPayment(student);
      emit(AddStudentSuccess());
    } catch (e) {
      final message = 'فشل في إضافة الطالب: ${e.toString()}';

      log('🔥 CUBIT EMITTING ERROR: $message');

      emit(AddStudentError('فشل في إضافة الطالب: ${e.toString()}'));
    }
  }

  Future<void> addStudentPayment(StudentsEntity student) async {
    try {
      emit(AddStudentPaymentLoading());
      final payment = PaymentEntity(
        id: const Uuid().v4(),
        studentId: student.id,
        studentName: student.name,
        groupId: student.groupId,
        year: DateTime.now().year,
        monthlyPayments: {
          for (var i = 1; i <= 12; i++) i.toString().padLeft(2, '0'): false,
        },
      );

      await addPaymentUseCase(payment);
      emit(AddStudentPaymentSuccess());
    } catch (e) {
      final message = 'فشل في إضافة مدفوعات: ${e.toString()}';

      log('🔥 CUBIT EMITTING ERROR: $message');

      emit(AddStudentPaymentError('فشل في إضافة الطالب: ${e.toString()}'));
    }
  }

  void submit(groupId) {
    if (formKey.currentState!.validate()) {
      final student = StudentsEntity(
        id: const Uuid().v4(),
        name: nameController.text.trim(),
        username: userNameController.text.trim(),
        groupId: groupId,
        parentPhone: parentPhoneController.text.trim(),
        phone: phoneController.text.trim(),
      );
      emit(AddStudentSubmitted(student));
    }
  }
}
