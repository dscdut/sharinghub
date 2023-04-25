part of 'campaign_register.bloc.dart';

class CampaignRegisterState extends Equatable {
  final bool isRegisted;
  final HandleStatus status;

  const CampaignRegisterState({
    this.isRegisted = false,
    required this.status,
  });

  const CampaignRegisterState.success({
    this.isRegisted = true,
    this.status = HandleStatus.success,
  });

  const CampaignRegisterState.loading({
    this.status = HandleStatus.loading,
    this.isRegisted = false,
  });

  @override
  List<Object?> get props => [
        isRegisted,
        status,
      ];
}

class CampaignRegisterError extends CampaignRegisterState {
  final String message;

  const CampaignRegisterError({
    required this.message,
    super.isRegisted = false,
    super.status = HandleStatus.error,
  });

  @override
  List<Object?> get props => [
        message,
        isRegisted,
      ];
}
