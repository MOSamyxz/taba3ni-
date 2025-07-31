import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/features/group_students/domain/repository/student_repository.dart';
import 'package:taba3ni/features/payment/domain/entity/payment_entity.dart';
import 'package:taba3ni/features/payment/domain/usecase/get_payments_by_group_usecase.dart';
import 'package:taba3ni/features/payment/domain/usecase/get_payments_usecase.dart';
import 'package:taba3ni/features/payment/domain/usecase/update_payment_usecase.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final GetPaymentsByGroupUseCase getPaymentsByGroupUseCase;
  final GetPaymentsUseCase getPaymentsByStudentUseCase;
  final UpdatePaymentUsecase updatePaymentUsecase;
  final StudentsRepository studentRepo;
  PaymentCubit({
    required this.getPaymentsByGroupUseCase,
    required this.getPaymentsByStudentUseCase,
    required this.updatePaymentUsecase,
    required this.studentRepo,
  }) : super(PaymentInitial());

  Future<void> loadGroupPayments(String groupId) async {
    emit(GroupPaymentsLoading());
    try {
      final payments = await getPaymentsByGroupUseCase(groupId);
      emit(GroupPaymentsLoaded(payments));
    } catch (e) {
      emit(GroupPaymentsError(e.toString()));
    }
  }

 Future<void> markMonthAsPaid(
  PaymentEntity payment,
  String month,
  void Function(PaymentEntity updated) onSuccess,
  void Function()? onError,
) async {
  try {
    final updatedMap = Map<String, bool>.from(payment.monthlyPayments);
    updatedMap[month] = true;

    final updatedPayment = payment.copyWith(monthlyPayments: updatedMap);

     onSuccess(updatedPayment);

     await updatePaymentUsecase(updatedPayment);
  } catch (e) {
    if (onError != null) onError();
    emit(GroupPaymentsError('فشل في تحديث حالة الدفع: $e'));
  }
}

}
