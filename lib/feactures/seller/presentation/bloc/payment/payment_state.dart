import 'package:equatable/equatable.dart';
import 'package:omega_caisse/feactures/seller/data/model/payment_model.dart';

abstract class PaymentState extends Equatable{}

class PaymentInitState extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentLoadingState extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentOrangeLoaderState extends PaymentState {
  final PaymentModel paymentResponse;
  PaymentOrangeLoaderState(this.paymentResponse);
  @override
  List<Object> get props => [];
}

class PaymentWaveLoaderState extends PaymentState {
  final PaymentModel paymentResponse;
  PaymentWaveLoaderState(this.paymentResponse);
  @override
  List<Object> get props => [];
}

class PaymentErrorState extends PaymentState {
  final String error;
  PaymentErrorState(this.error);

  @override
  List<Object> get props => [];
}