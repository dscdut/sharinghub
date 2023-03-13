part of 'profile.bloc.dart';

class ProfileState extends Equatable {
  final UserModel? user;
  final HandleStatus status;

  const ProfileState.initial()
      : user = null,
        status = HandleStatus.loading;

  const ProfileState({
    this.user,
    required this.status,
  });

  @override
  List<Object> get props => [];
}

class ProfileStateSucess extends ProfileState {
  const ProfileStateSucess({
    required UserModel user,
  }) : super(user: user, status: HandleStatus.success);
}
