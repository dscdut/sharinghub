part of 'login.bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmit extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmit({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
