part of 'profile.bloc.dart';

class ProfileState extends Equatable {
  final HandleStatus status;
  final UserModel? user;

  const ProfileState({
    this.status = HandleStatus.initial,
    this.user,
  });

  bool get isOrganizationMode =>
      (user != null && user!.currentOrganization != null);

  @override
  List<Object?> get props => [status, user];

  ProfileState copyWith({
    HandleStatus? status,
    UserModel? user,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
