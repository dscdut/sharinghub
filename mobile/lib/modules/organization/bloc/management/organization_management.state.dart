part of 'organization_management.bloc.dart';

class OrganizationManagementState extends Equatable {
  final HandleStatus status;
  final List<OrganizationModel> organizations;

  const OrganizationManagementState({
    this.status = HandleStatus.initial,
    this.organizations = const [],
  });

  @override
  List<Object> get props => [status, organizations];

  OrganizationManagementState copyWith({
    HandleStatus? status,
    List<OrganizationModel>? organizations,
  }) {
    return OrganizationManagementState(
      status: status ?? this.status,
      organizations: organizations ?? this.organizations,
    );
  }
}
