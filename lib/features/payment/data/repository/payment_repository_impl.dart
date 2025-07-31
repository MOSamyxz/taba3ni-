import 'package:taba3ni/features/payment/data/datasource/payment_remote_data_source.dart';
import 'package:taba3ni/features/payment/data/model/payment_model.dart';
import 'package:taba3ni/features/payment/domain/entity/payment_entity.dart';
import 'package:taba3ni/features/payment/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remote;

  PaymentRepositoryImpl(this.remote);

  @override
  Future<void> addPayment(PaymentEntity payment) {
    return remote.addPayment(PaymentModel(
      id: payment.id,
      studentId: payment.studentId,
      studentName: payment.studentName,
      groupId: payment.groupId,
      year: payment.year,
      monthlyPayments: payment.monthlyPayments,
    ));
  }

  @override
  Future<void> updatePayment(PaymentEntity payment) {
    return remote.updatePayment(PaymentModel(
      id: payment.id,
      studentId: payment.studentId,
      studentName: payment.studentName,
      groupId: payment.groupId,
      year: payment.year,
      monthlyPayments: payment.monthlyPayments,
    ));
  }

  @override
  Future<PaymentEntity> getPayment(String studentId, String groupId, int year) {
    return remote.getPayment(studentId, groupId, year);
  }

  @override
  Future<List<PaymentEntity>> getPaymentsByGroup(String groupId) {
    return remote.getPaymentsByGroup(groupId);
  }
}
