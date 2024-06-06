
  import 'package:equatable/equatable.dart';

import '../../../data/model/history_model.dart';
import '../../../data/model/order_model.dart';

abstract class HistoryState extends Equatable{}

  class HistoryLoadingState extends HistoryState {
  @override
  List<Object> get props => [];
  }

  class HistoryLoadedState extends HistoryState {
  final List<HistoryModel> orderList;
  HistoryLoadedState(this.orderList);
  @override
  List<Object> get props => [orderList];
  }

  class HistoryErrorState extends HistoryState {
  final String error;
  HistoryErrorState(this.error);

  @override
  List<Object> get props => [];
  }