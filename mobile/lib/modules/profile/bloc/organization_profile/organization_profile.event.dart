part of 'organization_profile.bloc.dart';

abstract class OrganizationProfileEvent extends Equatable {
  const OrganizationProfileEvent();

  @override
  List<Object> get props => [];
}

class OrganizationProfileGet extends OrganizationProfileEvent {
  final int organizationId;
  const OrganizationProfileGet(this.organizationId);

  @override
  List<Object> get props => [organizationId];
}
