part of 'donate.bloc.dart';

class DonateState extends Equatable {
  final HandleStatus status;
  final String? imageError;

  bool get isValid => imageError == null;

  const DonateState({
    this.status = HandleStatus.initial,
    this.imageError,
  });

  @override
  List<Object?> get props => [
        status,
        imageError,
      ];

  DonateState copyWith({
    HandleStatus? status,
    Wrapped<String?>? imageError,
  }) {
    return DonateState(
      status: status ?? this.status,
      imageError: imageError == null ? this.imageError : imageError.value,
    );
  }
}
