import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:taba3ni/features/payment/presentation/cubit/payment_state.dart';
import 'package:taba3ni/features/payment/domain/entity/payment_entity.dart';

class GroupPaymentsScreen extends StatefulWidget {
  final String groupId;

  const GroupPaymentsScreen({super.key, required this.groupId});

  @override
  State<GroupPaymentsScreen> createState() => _GroupPaymentsScreenState();
}

class _GroupPaymentsScreenState extends State<GroupPaymentsScreen> {
  late PaymentCubit _cubit;
  List<PaymentEntity> _localPayments = [];

  @override
  void initState() {
    super.initState();
    _cubit = sl<PaymentCubit>();
    _cubit.loadGroupPayments(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(title: Text('حالة الدفع لكل طالب')),
        body: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is GroupPaymentsLoaded) {
              // أول تحميل فقط
              _localPayments = List.from(state.payments);
            }
          },
          builder: (context, state) {
            if (_localPayments.isEmpty && state is! GroupPaymentsLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: _localPayments.length,
              itemBuilder: (context, index) {
                final payment = _localPayments[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '👤 الطالب: ${payment.studentName}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children:
                              payment.monthlyPayments.entries.map((entry) {
                                final month = entry.key;
                                final isPaid = entry.value;

                                if (isPaid) {
                                  return Chip(
                                    label: Text(
                                      '$month: ✅',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    backgroundColor: Colors.green[100],
                                  );
                                }

                                return ActionChip(
                                  label: Text(
                                    '$month: ❌',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  backgroundColor: Colors.red[100],
                                  onPressed: () {
                                    final oldPayment = _localPayments[index];

                                    final updatedMap = Map<String, bool>.from(
                                      payment.monthlyPayments,
                                    );
                                    updatedMap[month] = true;
                                    final updatedPayment = payment.copyWith(
                                      monthlyPayments: updatedMap,
                                    );

                                    setState(() {
                                      _localPayments[index] = updatedPayment;
                                    });

                                    _cubit.markMonthAsPaid(
                                      updatedPayment,
                                      month,
                                      (p) {},
                                      () {
                                        setState(() {
                                          _localPayments[index] = oldPayment;
                                        });
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'فشل تحديث حالة الدفع',
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
