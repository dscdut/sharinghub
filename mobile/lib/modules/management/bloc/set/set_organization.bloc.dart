import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/utils/wrapped_value.dart';
import 'package:mobile/data/dtos/set_organization.dto.dart';
import 'package:mobile/data/repositories/organization.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'set_organization.event.dart';
part 'set_organization.state.dart';

class SetOrganizationBloc
    extends Bloc<SetOrganizationEvent, SetOrganizationState> {
  final OrganizationRepository _organizationRepository;

  SetOrganizationBloc({required OrganizationRepository organizationRepository})
      : _organizationRepository = organizationRepository,
        super(const SetOrganizationState()) {
    on<SetOrganizationFormValidate>(_onValidateForm);
    on<SetOrganizationSubmit>(_onSubmitOrganization);
  }

  void _onValidateForm(
    SetOrganizationFormValidate event,
    Emitter<SetOrganizationState> emit,
  ) {
    emit(
      state.copyWith(
        avatarError: event.setOrganizationDTO.avatar == null
            ? Wrapped.value(LocaleKeys.validator_campaign_avatar_uploaded.tr())
            : const Wrapped.value(null),
      ),
    );
  }

  Future<void> _onSubmitOrganization(
    SetOrganizationSubmit event,
    Emitter<SetOrganizationState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HandleStatus.loading,
        avatarError: const Wrapped.value(null),
      ),
    );

    try {
      await _organizationRepository.setOrganization(event.setOrganization);

      emit(state.copyWith(status: HandleStatus.success));
    } catch (_) {
      emit(state.copyWith(status: HandleStatus.error));
    }
  }
}
