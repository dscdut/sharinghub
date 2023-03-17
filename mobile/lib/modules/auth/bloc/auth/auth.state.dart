part of 'auth.bloc.dart';

enum AuthenticationStatus {
  unknown,
  authenticatedUser,
  authenticatedOrganization,
  unauthenticated;

  bool get isAuthenticatedOrganization =>
      this == AuthenticationStatus.authenticatedOrganization;
}

class AuthState extends Equatable {
  final AuthenticationStatus status;
  final UserModel? user;

  int get currentOrganizationId => user!.currentOrganization!.id;

  const AuthState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticatedUser(UserModel user)
      : this._(status: AuthenticationStatus.authenticatedUser, user: user);

  const AuthState.authenticatedOrganization(UserModel user)
      : this._(
          status: AuthenticationStatus.authenticatedOrganization,
          user: user,
        );

  const AuthState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status];
}
