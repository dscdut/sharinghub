part of 'organization_profile.bloc.dart';

class OrganizationProfileState extends Equatable {
  final HandleStatus? status;
  final OrganizationModel? organization;

  const OrganizationProfileState({
    this.organization,
    this.status = HandleStatus.initial,
  });

  @override
  List<Object?> get props => [
        organization,
        status,
      ];

  OrganizationProfileState copyWith({
    OrganizationModel? organization,
    HandleStatus? status,
  }) {
    return OrganizationProfileState(
      organization: organization ?? this.organization,
      status: status ?? this.status,
    );
  }
}
