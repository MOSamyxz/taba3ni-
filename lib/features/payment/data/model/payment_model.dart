import 'package:taba3ni/features/payment/domain/entity/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  PaymentModel({
    required super.id,
    required super.studentId,
    required super.studentName,
    required super.groupId,
    required super.monthlyPayments,
    required super.year,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'],
      studentId: map['student_id'],
      studentName: map['student_name'],
      groupId: map['group_id'],
      year: map['year'],
      monthlyPayments: Map<String, bool>.from(map['monthly_payments']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_id': studentId,
      'student_name': studentName,
      'group_id': groupId,
      'year': year,
      'monthly_payments': monthlyPayments,
    };
  }
}
