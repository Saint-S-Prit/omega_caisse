
  import 'package:equatable/equatable.dart';

import '../../../data/model/order_model.dart';

abstract class OrderState extends Equatable{}

  class OrderLoadingState extends OrderState {
  @override
  List<Object> get props => [];
  }

  class OrderLoadedState extends OrderState {
  final String responseOrder;
  OrderLoadedState(this.responseOrder);
  @override
  List<Object> get props => [responseOrder];
  }

  class OrderErrorState extends OrderState {
  final String error;
  OrderErrorState(this.error);

  @override
  List<Object> get props => [];
  }