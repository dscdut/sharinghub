part of 'feedback_individual.bloc.dart';

abstract class FeedbackIndividualEvent extends Equatable {
  const FeedbackIndividualEvent();

  @override
  List<Object> get props => [];
}

class FeedbackIndividualInit extends FeedbackIndividualEvent {}

class FeedbackIndividualFormValidate extends FeedbackIndividualEvent {
  final FeedbackIndividualDTO individualFeedback;

  const FeedbackIndividualFormValidate({
    required this.individualFeedback,
  });

  @override
  List<Object> get props => [individualFeedback];
}

class FeedbackIndividualSubmit extends FeedbackIndividualEvent {
  final FeedbackIndividualDTO individualFeedback;

  const FeedbackIndividualSubmit({
    required this.individualFeedback,
  });

  @override
  List<Object> get props => [individualFeedback];
}
