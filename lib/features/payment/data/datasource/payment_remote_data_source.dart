import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taba3ni/features/payment/data/model/payment_model.dart';

abstract class PaymentRemoteDataSource {
  Future<void> addPayment(PaymentModel payment);
  Future<void> updatePayment(PaymentModel payment);
  Future<PaymentModel> getPayment(String studentId, String groupId, int year);
  Future<List<PaymentModel>> getPaymentsByGroup(String groupId);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final SupabaseClient supabase;

  PaymentRemoteDataSourceImpl(this.supabase);

  @override
  Future<void> addPayment(PaymentModel payment) async {
   await supabase
        .from('payments')
        .insert(payment.toMap());
  }

  @override
  Future<void> updatePayment(PaymentModel payment) async {
  await supabase
        .from('payments')
        .update(payment.toMap())
        .eq('id', payment.id);

 
  }

  @override
  Future<PaymentModel> getPayment(String studentId, String groupId, int year) async {
    final response = await supabase
        .from('payments')
        .select()
        .eq('studentId', studentId)
        .eq('groupId', groupId)
        .eq('year', year)
        .limit(1)
        .maybeSingle();

    if (response == null) {
      throw Exception('No payment record found');
    }

    return PaymentModel.fromMap(response);
  }

  @override
  Future<List<PaymentModel>> getPaymentsByGroup(String groupId) async {
    final response = await supabase
        .from('payments')
        .select()
        .eq('group_id', groupId);

    return (response as List)
        .map((item) => PaymentModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }
}
