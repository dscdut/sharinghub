part of 'feedback_campaign.bloc.dart';

class FeedbackCampaignState extends Equatable {
  final HandleStatus status;
  final String? rateError;
  final String? imageError;

  const FeedbackCampaignState({
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

  FeedbackCampaignState copyWith({
    HandleStatus? status,
    Wrapped<String?>? rateError,
    Wrapped<String?>? imageError,
  }) {
    return FeedbackCampaignState(
      status: status ?? this.status,
      rateError: rateError == null ? this.rateError : rateError.value,
      imageError: imageError == null ? this.imageError : imageError.value,
    );
  }
}
