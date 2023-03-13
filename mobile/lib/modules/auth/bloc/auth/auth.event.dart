part of 'auth.bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserInfoChecked extends AuthEvent {}

class AuthSetTokens extends AuthEvent {
  final AccessTokenDTO? accessToken;

  const AuthSetTokens({
    required this.accessToken,
  });

  @override
  List<Object?> get props => [accessToken];
}

class AuthLogOut extends AuthEvent {}
