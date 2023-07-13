part of 'organization_feedback.bloc.dart';

class OrganizationFeedbackState extends Equatable {
  final HandleStatus status;
  final String? rateError;
  final String? imageError;

  const OrganizationFeedbackState({
    this.status = HandleStatus.initial,
    this.rateError,
    this.imageError,
  });

  @override
  List<Object?> get props => [
        status,
        rateError,
        imageError,
      ];

  OrganizationFeedbackState copyWith({
    HandleStatus? status,
    Wrapped<String?>? rateError,
    Wrapped<String?>? imageError,
  }) {
    return OrganizationFeedbackState(
      status: status ?? this.status,
      rateError: rateError == null ? this.rateError : rateError.value,
      imageError: imageError == null ? this.imageError : imageError.value,
    );
  }
}
