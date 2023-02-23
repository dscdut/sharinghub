part of 'auth.bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthGetUserInfo extends AuthEvent {}

class AuthSetUser extends AuthEvent {
  // final UserModel? currentUser;
  final String? currentEmail;
  final String? password;

  const AuthSetUser({
    required this.currentEmail,
    required this.password,
  });

  @override
  List<Object?> get props => [
        currentEmail,
        password,
      ];
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
