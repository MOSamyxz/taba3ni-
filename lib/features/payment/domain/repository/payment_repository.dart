import 'package:taba3ni/features/payment/domain/entity/payment_entity.dart';

abstract class PaymentRepository {
  Future<void> addPayment(PaymentEntity payment);
  Future<void> updatePayment(PaymentEntity payment);
  Future<PaymentEntity> getPayment(String studentId, String groupId, int year);
  Future<List<PaymentEntity>> getPaymentsByGroup(String groupId);
}
