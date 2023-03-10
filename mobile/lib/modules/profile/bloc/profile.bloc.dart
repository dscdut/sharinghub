import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/user.repository.dart';

part 'profile.event.dart';
part 'profile.state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;

  ProfileBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const ProfileState.initial()) {
    on<ProfileEventStarted>(_getProfile);
    add(const ProfileEventStarted());
  }

  Future<void> _getProfile(
    ProfileEvent state,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(
        ProfileStateSucess(
          user: await _userRepository.getUserProfile(),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
