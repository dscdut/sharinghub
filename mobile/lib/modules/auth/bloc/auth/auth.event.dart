part of 'auth.bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserInfoChecked extends AuthEvent {}

class AuthTokensSet extends AuthEvent {
  final TokenDTO? tokenDTO;

  const AuthTokensSet({
    required this.tokenDTO,
  });

  @override
  List<Object?> get props => [tokenDTO];
}

class AuthLogOut extends AuthEvent {}
