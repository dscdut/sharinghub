part of 'paticipant_feedback.bloc.dart';

abstract class ParticipantFeedbackEvent extends Equatable {
  const ParticipantFeedbackEvent();

  @override
  List<Object> get props => [];
}

class ParticipantFeedbackInit extends ParticipantFeedbackEvent {}

class ParticipantFeedbackFormValidate extends ParticipantFeedbackEvent {
  final ParticipantFeedbackDTO individualFeedback;

  const ParticipantFeedbackFormValidate({
    required this.individualFeedback,
  });

  @override
  List<Object> get props => [individualFeedback];
}

class ParticipantFeedbackSubmit extends ParticipantFeedbackEvent {
  final ParticipantFeedbackDTO individualFeedback;

  const ParticipantFeedbackSubmit({
    required this.individualFeedback,
  });

  @override
  List<Object> get props => [individualFeedback];
}
