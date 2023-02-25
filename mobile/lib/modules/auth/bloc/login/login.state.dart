part of 'login.bloc.dart';

abstract class LoginState extends Equatable {
  final String? error;

  const LoginState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginNotSuccess extends LoginState {
  const LoginNotSuccess({super.error});
}

class LoginSuccess extends LoginState {}
