import 'package:applicatio01statemanagment/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressedEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressedEvent(
      {required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
