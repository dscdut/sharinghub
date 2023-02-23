part of 'auth.bloc.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthenticationStatus.unknown,
    this.email,
    this.password,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated({
    required String email,
    required String password,
  }) : this._(
          status: AuthenticationStatus.authenticated,
          email: email,
          password: password,
        );

  const AuthState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final String? email;
  final String? password;

  @override
  List<Object?> get props => [
        status,
        email,
        password,
      ];
}
