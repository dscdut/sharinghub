import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_organization.event.dart';
part 'profile_organization.state.dart';

class ProfileOrganizationBloc extends Bloc<ProfileOrganizationEvent, ProfileOrganizationState> {
  ProfileOrganizationBloc() : super(ProfileOrganizationInitial()) {
    on<ProfileOrganizationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
