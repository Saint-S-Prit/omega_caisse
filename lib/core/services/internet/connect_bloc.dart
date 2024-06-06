// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
//
// import 'connect_event.dart';
// import 'connect_state.dart';
//
//
// class InternetBloc extends Bloc<InternetEvent, ConnectState> {
//
//
//   StreamSubscription? subscription;
//
//   InternetBloc() : super(InitState()){
//     on<onConnectedEvent>((event, emit) => emit(ConnectedState(message: 'Connected...')));
//     on<onNotConnectedEvent>((event, emit) => emit(ConnectedState(message: 'Not connected...')));
//     subscription = Connectivity().onConnectivityChanged
//     .listen((ConnectivityResult result){
//       if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
//         add(onConnectedEvent());
//       }
//       else
//         {
//           add(onNotConnectedEvent());
//         }
//
//     });
//   }
// }
