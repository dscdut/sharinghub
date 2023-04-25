import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'individual_feedback.event.dart';
part 'individual_feedback.state.dart';

class IndividualFeedbackBloc
    extends Bloc<IndividualFeedbackEvent, IndividualFeedbackState> {
  IndividualFeedbackBloc() : super(const IndividualFeedbackState()) {
    on<IndividualFeedbackEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
