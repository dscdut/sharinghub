part of 'set_user_profile.bloc.dart';

abstract class SetUserEvent extends Equatable {
  const SetUserEvent();

  @override
  List<Object> get props => [];
}

class SetUserFormValidate extends SetUserEvent {
  final SetUserDTO setUserDTO;

  const SetUserFormValidate({required this.setUserDTO});

  @override
  List<Object> get props => [setUserDTO];
}

class SetUserSubmit extends SetUserEvent {
  final SetUserDTO setUser;

  const SetUserSubmit({required this.setUser});

  @override
  List<Object> get props => [setUser];
}
