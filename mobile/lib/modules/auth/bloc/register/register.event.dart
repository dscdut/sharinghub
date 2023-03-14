part of 'register.bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterSubmit extends RegisterEvent {
  final SubmitRegisterDTO submitRegister;

  const RegisterSubmit(
    this.submitRegister,
  );

  @override
  List<Object?> get props => [submitRegister];
}
