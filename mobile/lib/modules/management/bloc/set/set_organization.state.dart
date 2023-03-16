part of 'set_organization.bloc.dart';

class SetOrganizationState extends Equatable {
  final HandleStatus status;
  final String? avatarError;
  final String? error;

  const SetOrganizationState({
    this.status = HandleStatus.initial,
    this.avatarError,
    this.error,
  });

  bool get isValid => avatarError != null;

  @override
  List<Object?> get props => [
        status,
        avatarError,
        error,
      ];

  SetOrganizationState copyWith({
    HandleStatus? status,
    Wrapped<String?>? avatarError,
    String? error,
  }) {
    return SetOrganizationState(
      status: status ?? this.status,
      avatarError: avatarError == null ? this.avatarError : avatarError.value,
      error: error ?? this.error,
    );
  }
}
