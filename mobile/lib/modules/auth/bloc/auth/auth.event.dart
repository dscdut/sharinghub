part of 'auth.bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserInfoChecked extends AuthEvent {}

class AuthUserInfoSet extends AuthEvent {
  final AuthResponseDTO? authResponse;

  const AuthUserInfoSet({required this.authResponse});

  @override
  List<Object?> get props => [authResponse];
}

// class AuthSetTokens extends AuthEvent {
//   final RefreshTokenDTO? refreshToken;

//   const AuthSetTokens({
//     required this.refreshToken,
//   });

//   @override
//   List<Object?> get props => [refreshToken];
// }

class AuthLogOut extends AuthEvent {}
