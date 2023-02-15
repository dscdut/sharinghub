part of 'auth.bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthGetUserInfo extends AuthEvent {}

class AuthSetUser extends AuthEvent {
  final UserModel? currentUser;

  const AuthSetUser({required this.currentUser});

  @override
  List<Object?> get props => [currentUser];
}

class AuthSetTokens extends AuthEvent {
  final RefreshTokenDTO? refreshToken;

  const AuthSetTokens({
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [refreshToken];
}

class AuthLogOut extends AuthEvent {}
