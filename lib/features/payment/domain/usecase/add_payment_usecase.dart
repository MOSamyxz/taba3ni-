import 'package:taba3ni/features/payment/domain/entity/payment_entity.dart';
import 'package:taba3ni/features/payment/domain/repository/payment_repository.dart';

class AddPaymentUseCase {
  final PaymentRepository repository;

  AddPaymentUseCase(this.repository);

  Future<void> call(PaymentEntity payment) {
    return repository.addPayment(payment);
  }
}
