part of 'register.bloc.dart';

abstract class RegisterState extends Equatable {
  final String? emailError;

  const RegisterState({
    this.emailError,
  });

  @override
  List<Object?> get props => [
        emailError,
      ];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterNotSuccess extends RegisterState {
  const RegisterNotSuccess({super.emailError});
}

class RegisterSuccess extends RegisterState {}
