import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/utils/wrapped_value.dart';
import 'package:mobile/data/dtos/set_user.dto.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'set_user_profile.event.dart';
part 'set_user_profile.state.dart';

class SetUserBloc extends Bloc<SetUserEvent, SetUserState> {
  final UserRepository _userRepository;

  SetUserBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const SetUserState()) {
    on<SetUserFormValidate>(_onValidateForm);
    on<SetUserSubmit>(_onSubmitUser);
  }

  void _onValidateForm(
    SetUserFormValidate event,
    Emitter<SetUserState> emit,
  ) {
    emit(
      state.copyWith(
        avatarError: event.setUserDTO.avatar == null
            ? Wrapped.value(
                LocaleKeys.validator_organization_avatar_uploaded.tr(),
              )
            : const Wrapped.value(null),
      ),
    );
  }

  Future<void> _onSubmitUser(
    SetUserSubmit event,
    Emitter<SetUserState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HandleStatus.loading,
        avatarError: const Wrapped.value(null),
      ),
    );

    try {
      await _userRepository.setUser(event.setUser);

      emit(state.copyWith(status: HandleStatus.success));
    } catch (e) {
      emit(state.copyWith(status: HandleStatus.error));
    }
  }
}
