part of 'set_campaign.bloc.dart';

class SetCampaignState extends Equatable {
  final HandleStatus status;
  final String? imageError;
  final String? dateRangeError;

  bool get isValid => imageError == null && dateRangeError == null;

  const SetCampaignState({
    this.status = HandleStatus.initial,
    this.imageError,
    this.dateRangeError,
  });

  @override
  List<Object?> get props => [
        status,
        imageError,
      ];

  SetCampaignState copyWith({
    HandleStatus? status,
    Wrapped<String?>? imageError,
    Wrapped<String?>? dateRangeError,
  }) {
    return SetCampaignState(
      status: status ?? this.status,
      imageError: imageError == null ? this.imageError : imageError.value,
      dateRangeError:
          dateRangeError == null ? this.dateRangeError : dateRangeError.value,
    );
  }
}
