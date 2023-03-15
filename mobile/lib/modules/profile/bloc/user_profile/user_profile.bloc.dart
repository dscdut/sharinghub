import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/user.repository.dart';

part 'user_profile.state.dart';
part 'user_profile.event.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository _userRepository;

  UserProfileBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(
          const UserProfileState.initial(),
        ) {
    on<UserProfileStarted>(_getUserProfile);
    add(const UserProfileStarted());
  }

  Future<void> _getUserProfile(
    UserProfileEvent event,
    Emitter<UserProfileState> emitter,
  ) async {
    try {
      emitter(
        UserProfileState.success(
          user: await _userRepository.getUserProfile(),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
