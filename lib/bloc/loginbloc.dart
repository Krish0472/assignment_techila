import 'dart:async';

import 'package:applicatio01statemanagment/bloc/loginEvent.dart';
import 'package:applicatio01statemanagment/bloc/loginstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc() : super(InitialLoginState()) {
    on<LoginButtonPressedEvent>((event, emit) async{
        // When the login button event occures
        if(event.username.isNotEmpty && event.password.isNotEmpty){
          emit(LoadingLoginState());
          await Future.delayed(const Duration(seconds: 2));
          print("username ${event.username}");
          print("password ${event.password}");
          emit(SuccessLoginState());
        }
    });
  }
}



/*
@override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoadingLoginState();
      await Future.delayed(Duration(seconds: 2));
      if (event.username == "username" && event.password == "password") {
        yield SuccessLoginState();
      } else {
        yield ErrorLoginState(error: "Invalid credentials");
      }
    }
  }
 */