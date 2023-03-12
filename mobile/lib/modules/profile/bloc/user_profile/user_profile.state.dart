part of 'user_profile.bloc.dart';

class UserProfileState extends Equatable {
  final HandleStatus status;
  final UserProfileModel? user;

  const UserProfileState({
    required this.status,
    this.user,
  });

  const UserProfileState.initial()
      : this(
          status: HandleStatus.loading,
        );

  const UserProfileState.success({
    required UserProfileModel user,
  }) : this(
          status: HandleStatus.success,
          user: user,
        );

  @override
  List<Object?> get props => [
        status,
        user,
      ];
}
