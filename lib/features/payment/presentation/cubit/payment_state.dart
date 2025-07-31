import 'package:equatable/equatable.dart';
import 'package:taba3ni/features/payment/domain/entity/payment_entity.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<PaymentEntity> payments;

  const PaymentLoaded(this.payments);

  @override
  List<Object?> get props => [payments];
}

class PaymentUpdated extends PaymentState {}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError(this.message);

  @override
  List<Object?> get props => [message];
}

class GroupPaymentsLoading extends PaymentState {}

class GroupPaymentsLoaded extends PaymentState {
  final List<PaymentEntity> payments;

  const GroupPaymentsLoaded(this.payments);

  @override
  List<Object?> get props => [payments];
}

class GroupPaymentsError extends PaymentState {
  final String error;

  const GroupPaymentsError(this.error);

  @override
  List<Object?> get props => [error];
}