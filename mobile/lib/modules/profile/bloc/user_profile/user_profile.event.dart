part of 'user_profile.bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class UserProfileStarted extends UserProfileEvent {
  const UserProfileStarted();
}
