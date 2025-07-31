import 'package:taba3ni/features/payment/domain/entity/payment_entity.dart';
import 'package:taba3ni/features/payment/domain/repository/payment_repository.dart';

class GetPaymentsByGroupUseCase {
  final PaymentRepository repository;

  GetPaymentsByGroupUseCase(this.repository);

  Future<List<PaymentEntity>> call(String groupId) {
    return repository.getPaymentsByGroup(groupId);
  }
}
