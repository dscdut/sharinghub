part of 'paticipant_feedback.bloc.dart';

class ParticipantFeedbackState extends Equatable {
  final HandleStatus status;
  final String? campaignRateError;
  final String? organizationRateError;

  const ParticipantFeedbackState({
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

  ParticipantFeedbackState copyWith({
    HandleStatus? status,
    Wrapped<String?>? campaignRateError,
    Wrapped<String?>? organizationRateError,
  }) {
    return ParticipantFeedbackState(
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
