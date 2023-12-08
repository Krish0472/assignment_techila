import 'dart:async';
import 'package:assignment_techila/bloc/login_event.dart';
import 'package:assignment_techila/bloc/login_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState()) {
    on<LoginButtonPressedEvent>((event, emit) async {

      /// When the login button event occures
      if (event.username.isNotEmpty && event.password.isNotEmpty) {
        emit(LoadingLoginState());
        await Future.delayed(const Duration(seconds: 2));
        debugPrint("username ${event.username}");
        debugPrint("password ${event.password}");
        emit(SuccessLoginState());
      }
    });
  }
}


