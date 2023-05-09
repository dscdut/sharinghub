part of 'feedback_individual.bloc.dart';

class FeedbackIndividualState extends Equatable {
  final HandleStatus status;
  final String? campaignRateError;
  final String? organizationRateError;

  const FeedbackIndividualState({
    this.status = HandleStatus.initial,
    this.campaignRateError,
    this.organizationRateError,
  });

  @override
  List<Object?> get props => [
        status,
        campaignRateError,
        organizationRateError,
      ];

  FeedbackIndividualState copyWith({
    HandleStatus? status,
    Wrapped<String?>? campaignRateError,
    Wrapped<String?>? organizationRateError,
  }) {
    return FeedbackIndividualState(
      status: status ?? this.status,
      campaignRateError: campaignRateError == null
          ? this.campaignRateError
          : campaignRateError.value,
      organizationRateError: organizationRateError == null
          ? this.organizationRateError
          : organizationRateError.value,
    );
  }
}
