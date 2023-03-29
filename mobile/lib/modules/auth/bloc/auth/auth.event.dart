part of 'auth.bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserInfoChecked extends AuthEvent {}

class AuthUserAuthInfoSet extends AuthEvent {
  final LoginResponseDTO? loginResponse;

  const AuthUserAuthInfoSet(this.loginResponse);

  @override
  List<Object?> get props => [loginResponse];
}

class AuthModeSwitch extends AuthEvent {
  final OrganizationModel? organization;

  const AuthModeSwitch(this.organization);

  @override
  List<Object?> get props => [organization];
}

class AuthLogOut extends AuthEvent {}
