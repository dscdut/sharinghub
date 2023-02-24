part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class PersonalRegisterButtonPressed extends RegisterEvent {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  const PersonalRegisterButtonPressed({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [
        fullName,
        email,
        password,
        confirmPassword,
      ];
}

class OrganizationRegisterButtonPressed extends RegisterEvent {
  final String organizationName;
  final String organizationCEO;
  final String email;
  final String password;
  final String confirmPassword;

  const OrganizationRegisterButtonPressed({
    required this.organizationName,
    required this.organizationCEO,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [
        organizationName,
        organizationCEO,
        email,
        password,
        confirmPassword,
      ];
}
