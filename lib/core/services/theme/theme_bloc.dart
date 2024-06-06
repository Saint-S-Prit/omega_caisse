import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:omega_caisse/core/services/theme/theme_event.dart';

import '../storage/local_storage_service.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.system){
    on<ThemeChanged>((event, emit){
      emit(event.isDark ? ThemeMode.dark : ThemeMode.light);
    });
  }



}