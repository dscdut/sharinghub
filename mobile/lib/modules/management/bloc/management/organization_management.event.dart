part of 'organization_management.bloc.dart';

abstract class OrganizationManagementEvent extends Equatable {
  const OrganizationManagementEvent();

  @override
  List<Object> get props => [];
}

class OrganizationManagementGet extends OrganizationManagementEvent {}
