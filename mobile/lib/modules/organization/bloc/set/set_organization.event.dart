part of 'set_organization.bloc.dart';

abstract class SetOrganizationEvent extends Equatable {
  const SetOrganizationEvent();

  @override
  List<Object> get props => [];
}

class SetOrganizationFormValidate extends SetOrganizationEvent {
  final SetOrganizationDTO setOrganizationDTO;

  const SetOrganizationFormValidate({required this.setOrganizationDTO});

  @override
  List<Object> get props => [setOrganizationDTO];
}

class SetOrganizationSubmit extends SetOrganizationEvent {
  final SetOrganizationDTO setOrganization;

  const SetOrganizationSubmit({required this.setOrganization});

  @override
  List<Object> get props => [setOrganization];
}
