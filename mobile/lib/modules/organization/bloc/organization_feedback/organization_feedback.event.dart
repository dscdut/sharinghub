part of 'organization_feedback.bloc.dart';

abstract class OrganizationFeedbackEvent extends Equatable {
  const OrganizationFeedbackEvent();

  @override
  List<Object> get props => [];
}

class OrganizationFeedbackInit extends OrganizationFeedbackEvent {}

class OrganizationFeedbackFormValidate extends OrganizationFeedbackEvent {
  final OrganizationFeedbackDTO organizationFeedback;

  const OrganizationFeedbackFormValidate({
    required this.organizationFeedback,
  });

  @override
  List<Object> get props => [organizationFeedback];
}

class OrganizationFeedbackSubmit extends OrganizationFeedbackEvent {
  final OrganizationFeedbackDTO organizationFeedback;
  final bool isUpdate;

  const OrganizationFeedbackSubmit({
    required this.organizationFeedback,
    this.isUpdate = false,
  });

  @override
  List<Object> get props => [organizationFeedback];
}
