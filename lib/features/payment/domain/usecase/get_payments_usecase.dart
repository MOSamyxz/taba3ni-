import 'package:taba3ni/features/payment/domain/entity/payment_entity.dart';
import 'package:taba3ni/features/payment/domain/repository/payment_repository.dart';

class GetPaymentsUseCase {
  final PaymentRepository repository;

  GetPaymentsUseCase(this.repository);

  Future<PaymentEntity>  call(String studentId,
  String groupId,
  int year,) {
    return repository.getPayment( studentId,  groupId,  year);
  }
}
