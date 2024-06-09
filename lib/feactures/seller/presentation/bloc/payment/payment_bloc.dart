import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_caisse/feactures/seller/domain/repository/payment_repo.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitState()) {
    on<PaymentWaveSubmittedEvent>((event, emit) async {
      emit(PaymentLoadingState());
      try {
        final paymentResponse = await PaymentRepo().payedByWave(phone: event.phone);
        emit(PaymentWaveLoaderState(paymentResponse!));
      } catch (e) {
        emit(PaymentErrorState(e.toString()));
      }
    });

    on<PaymentOrangeSubmittedEvent>((event, emit) async {
      emit(PaymentLoadingState());
      try {
        final paymentResponse = await PaymentRepo().payedByOrange(phone: event.phone, ussdCode: event.ussdCode);
        emit(PaymentOrangeLoaderState(paymentResponse));
      } catch (e) {
        emit(PaymentErrorState(e.toString()));
      }
    });
  }
}

