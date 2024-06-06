import 'package:bloc/bloc.dart';

import '../../../domain/repository/history_repo.dart';
import '../../../domain/repository/order_repo.dart';
import 'order_event.dart';
import 'order_state.dart';


class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderLoadingState()) {
    on<OrderEvent>((event, emit) async {
      if (event is OrderLoadedEvent) {
        emit(OrderLoadingState());
        try {
          final order = await OrderRepository().createOrder(variableMap: event.variableMap
          );
          emit(OrderLoadedState(order));
        } catch (e) {
          emit(OrderErrorState(e.toString()));
        }
      }
    });


  }
}
