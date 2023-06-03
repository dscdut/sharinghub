import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/modules/auth/auth.dart';

part 'profile.event.dart';
part 'profile.state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;

  ProfileBloc({
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        super(const ProfileState()) {
    on<ProfileEventStarted>(_onStartedGetProfile);
    add(const ProfileEventStarted());
  }

  Future<void> _onStartedGetProfile(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        user: _authBloc.state.user,
        status: HandleStatus.success,
      ),
    );
  }
}
