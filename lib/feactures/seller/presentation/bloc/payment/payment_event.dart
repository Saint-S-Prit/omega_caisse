import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {

  const PaymentEvent();
  @override
  List<Object> get props => [];
}


class PaymentOrangeSubmittedEvent extends PaymentEvent {
  final String phone;
  final String ussdCode;
  const PaymentOrangeSubmittedEvent({required this.phone, required this.ussdCode});
  @override
  List<Object> get props => [phone, ussdCode];
}

class PaymentWaveSubmittedEvent extends PaymentEvent {
  final String phone;
  const PaymentWaveSubmittedEvent({required this.phone});

  //  PaymentWaveSubmittedEvent({required this.phone}) {
  //   print("*************enter***************");
  // }
  @override
  List<Object> get props => [phone];
}
