 import 'package:uuid/uuid.dart';

class PaymentEntity {
  final String id;
  final String studentId;
  final String studentName;
  final String groupId;
  final int year;
  final Map<String, bool> monthlyPayments;

  PaymentEntity({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.groupId,
    required this.monthlyPayments,
    required this.year,
  });

PaymentEntity copyWith({
  String? id,
  String? studentId,
  String? studentName,
  String? groupId,
  int? year,
  Map<String, bool>? monthlyPayments,
 }) {
  return PaymentEntity(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    studentName: studentName ?? this.studentName,
    groupId: groupId ?? this.groupId,
    year: year ?? this.year,
    monthlyPayments: monthlyPayments ?? this.monthlyPayments,
   );
}

   factory PaymentEntity.initial(String studentId, String studentName ,String groupId, int year) {
    return PaymentEntity(
      id: Uuid().v4(),
      studentId: studentId,
      studentName: studentName,
      groupId: groupId,
      year: year,
      monthlyPayments: {
        for (var i = 1; i <= 12; i++) i.toString().padLeft(2, '0'): false
      },
    );
}
}