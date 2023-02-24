part of 'register.bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterSubmit extends RegisterEvent {
  final String name;
  final String? representativeName;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterSubmit({
    required this.name,
    this.representativeName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        name,
        representativeName,
        email,
        password,
        confirmPassword,
      ];
}
