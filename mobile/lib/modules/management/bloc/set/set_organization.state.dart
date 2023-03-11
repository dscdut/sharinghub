part of 'set_organization.bloc.dart';

class SetOrganizationState extends Equatable {
  final HandleStatus status;
  final String? avatarError;

  const SetOrganizationState({
    this.status = HandleStatus.initial,
    this.avatarError,
  });

  bool get isValid => avatarError != null;

  @override
  List<Object?> get props => [status, avatarError];

  SetOrganizationState copyWith({
    HandleStatus? status,
    Wrapped<String?>? avatarError,
  }) {
    return SetOrganizationState(
      status: status ?? this.status,
      avatarError: avatarError == null ? this.avatarError : avatarError.value,
    );
  }
}
