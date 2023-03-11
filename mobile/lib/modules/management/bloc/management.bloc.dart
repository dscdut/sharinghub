import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'management.event.dart';
part 'management.state.dart';

class ManagementBloc extends Bloc<ManagementEvent, ManagementState> {
  ManagementBloc() : super(const ManagementState()) {
    on<ManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
