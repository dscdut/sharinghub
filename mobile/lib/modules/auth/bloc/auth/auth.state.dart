part of 'auth.bloc.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  final AuthenticationStatus status;
  final UserModel? user;

  const AuthState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated()
      : this._(
          status: AuthenticationStatus.authenticated,
        );

  const AuthState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}
