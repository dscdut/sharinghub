part of 'register.bloc.dart';

class RegisterState extends Equatable {
  final HandleStatus? status;
  final String? error;

  const RegisterState({
    this.status = HandleStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        error,
      ];

  RegisterState copyWith({
    HandleStatus? status,
    String? error,
  }) {
    return RegisterState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
