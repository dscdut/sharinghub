part of 'profile.bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileEventStarted extends ProfileEvent {
  const ProfileEventStarted();
}
