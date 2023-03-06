part of 'organization_profile.bloc.dart';

class OrganizationProfileState extends Equatable {
  final OrganizationModel? organization;
  final HandleStatus? status;
  final String? error;

  const OrganizationProfileState({
    this.organization,
    this.status = HandleStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [
        organization,
        status,
        error,
      ];

  OrganizationProfileState copyWith({
    OrganizationModel? organization,
    HandleStatus? status,
    String? error,
  }) {
    return OrganizationProfileState(
      organization: organization ?? this.organization,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
