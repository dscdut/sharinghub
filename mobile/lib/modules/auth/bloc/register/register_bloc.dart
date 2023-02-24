import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/repositories/organization.repository.dart';
import 'package:mobile/data/repositories/personal.repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class OrganizationRegisterBloc
    extends Bloc<RegisterEvent, OrganizationRegisterState> {
  final OrganizationRepository _organizationRepository;

  OrganizationRegisterBloc({
    required OrganizationRepository organizationRepository,
  })  : _organizationRepository = organizationRepository,
        super(const OrganizationRegisterState()) {
    on<OrganizationRegisterButtonPressed>(_onOrganizationRegisterButtonPressed);
  }

  Future<void> _onOrganizationRegisterButtonPressed(
    OrganizationRegisterButtonPressed event,
    Emitter<OrganizationRegisterState> emitter,
  ) async {
    emitter(state.copyWith(loadingStatus: LoadingStatus.loading));

    if (event.organizationName.isEmpty) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          organizationNameError: 'Organization name is required',
        ),
      );
      return;
    }
    if (event.organizationCEO.isEmpty) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          organizationCEOError: 'Organization CEO is required',
        ),
      );
      return;
    }
    if (event.email.isEmpty) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          emailError: 'Email is required',
        ),
      );
      return;
    }
    if (event.password.isEmpty) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          passwordError: 'Password is required',
        ),
      );
      return;
    }
    if (event.confirmPassword.isEmpty) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          confirmPasswordError: 'Confirm password is required',
        ),
      );
      return;
    }
    if (event.password.length < 8) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          passwordError: 'Password must be at least 8 characters',
        ),
      );
      return;
    }
    if (event.password != event.confirmPassword) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          confirmPasswordError: 'Passwords do not match',
        ),
      );
      return;
    }
    try {
      await _organizationRepository.registerByEmail(
        OrganizationRegisterDTO(
          organizationName: event.organizationName,
          organizationCEO: event.organizationCEO,
          email: event.email,
          password: event.password,
        ),
      );
      emitter(state.copyWith(loadingStatus: LoadingStatus.done));
    } on DioError catch (error) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          emailError: error.response?.data['message'].toString(),
        ),
      );
      log(error.toString());
    }
  }
}

class PersonalRegisterBloc extends Bloc<RegisterEvent, PersonalRegisterState> {
  final PersonalRepository _personalRepository;

  PersonalRegisterBloc({
    required PersonalRepository personalRepository,
  })  : _personalRepository = personalRepository,
        super(const PersonalRegisterState()) {
    on<PersonalRegisterButtonPressed>(_onPersonalRegisterButtonPressed);
  }
  
  Future<void> _onPersonalRegisterButtonPressed(
    PersonalRegisterButtonPressed event,
    Emitter<PersonalRegisterState> emitter,
  ) async {
    emitter(state.copyWith(loadingStatus: LoadingStatus.loading));

    if (event.fullName.isEmpty) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          fullNameError: 'Personal name is required',
        ),
      );
      return;
    }
    if (event.email.isEmpty) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          emailError: 'Email is required',
        ),
      );
      return;
    }
    if (event.password.isEmpty) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          passwordError: 'Password is required',
        ),
      );
      return;
    }
    if (event.confirmPassword.isEmpty) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          confirmPasswordError: 'Confirm password is required',
        ),
      );
      return;
    }
    if (event.password.length < 8) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          passwordError: 'Password must be at least 8 characters',
        ),
      );
      return;
    }
    if (event.password != event.confirmPassword) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          confirmPasswordError: 'Passwords do not match',
        ),
      );
      return;
    }
    try {
      await _personalRepository.registerByEmail(
        PersonalRegisterDTO(
          fullName: event.fullName,
          email: event.email,
          password: event.password,
        ),
      );
      emitter(state.copyWith(loadingStatus: LoadingStatus.done));
    } on DioError catch (error) {
      emitter(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          emailError: error.response?.data['message'].toString(),
        ),
      );
      log(error.toString());
    }
  }
}
