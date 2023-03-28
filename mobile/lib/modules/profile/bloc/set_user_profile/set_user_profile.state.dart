part of 'set_user_profile.bloc.dart';

class SetUserState extends Equatable {
  final HandleStatus status;
  final String? avatarError;
  final String? error;

  const SetUserState({
    this.status = HandleStatus.initial,
    this.avatarError,
    this.error,
  });

  bool get isValid => avatarError == null;

  @override
  List<Object?> get props => [
        status,
        avatarError,
        error,
      ];

  SetUserState copyWith({
    HandleStatus? status,
    Wrapped<String?>? avatarError,
    String? error,
  }) {
    return SetUserState(
      status: status ?? this.status,
      avatarError: avatarError == null ? this.avatarError : avatarError.value,
      error: error ?? this.error,
    );
  }
}
