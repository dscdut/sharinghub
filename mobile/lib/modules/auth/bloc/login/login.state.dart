part of 'login.bloc.dart';

abstract class LoginState extends Equatable {
  final String? emailError;
  final String? passwordError;

  const LoginState({
    this.emailError,
    this.passwordError,
  });

  @override
  List<Object?> get props => [emailError, passwordError];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginNotSuccess extends LoginState {
  const LoginNotSuccess({
    super.emailError,
    super.passwordError,
  });
}

class LoginSuccess extends LoginState {}
