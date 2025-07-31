import 'package:taba3ni/features/payment/domain/entity/payment_entity.dart';
import 'package:taba3ni/features/payment/domain/repository/payment_repository.dart';

class UpdatePaymentUsecase {
  final PaymentRepository repository;

  UpdatePaymentUsecase(this.repository);

  Future<void> call(  PaymentEntity payment) {
    return repository.updatePayment(payment);
  }
}
