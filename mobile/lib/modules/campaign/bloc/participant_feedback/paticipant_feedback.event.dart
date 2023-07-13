part of 'paticipant_feedback.bloc.dart';

abstract class ParticipantFeedbackEvent extends Equatable {
  const ParticipantFeedbackEvent();

  @override
  List<Object> get props => [];
}

class ParticipantFeedbackInit extends ParticipantFeedbackEvent {}

class ParticipantFeedbackFormValidate extends ParticipantFeedbackEvent {
  final ParticipantFeedbackDTO participantFeedbackDTO;

  const ParticipantFeedbackFormValidate({
    required this.participantFeedbackDTO,
  });

  @override
  List<Object> get props => [participantFeedbackDTO];
}

class ParticipantFeedbackSubmit extends ParticipantFeedbackEvent {
  final ParticipantFeedbackDTO participantFeedback;
  final bool isUpdate;

  const ParticipantFeedbackSubmit({
    required this.participantFeedback,
    this.isUpdate = false,
  });

  @override
  List<Object> get props => [
        participantFeedback,
        isUpdate,
      ];
}
