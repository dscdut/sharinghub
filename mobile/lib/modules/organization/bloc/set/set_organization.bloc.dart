import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/utils/wrapped_value.dart';
import 'package:mobile/data/dtos/set_organization.dto.dart';
import 'package:mobile/data/repositories/organization.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/organization/management.dart';

part 'set_organization.event.dart';
part 'set_organization.state.dart';

class SetOrganizationBloc
    extends Bloc<SetOrganizationEvent, SetOrganizationState> {
  final OrganizationRepository _organizationRepository;
  final OrganizationManagementBloc? _organizationManagementBloc;

  SetOrganizationBloc({
    required OrganizationRepository organizationRepository,
    required OrganizationManagementBloc? organizationManagementBloc,
  })  : _organizationRepository = organizationRepository,
        _organizationManagementBloc = organizationManagementBloc,
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
        avatarError: event.setOrganizationDTO.image == null
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

      _organizationManagementBloc?.add(OrganizationManagementGet());

      emit(state.copyWith(status: HandleStatus.success));
    } on DioError catch (e) {
      // Handle case when organization name or phone is duplicated
      if (e.response?.statusCode == 409) {
        emit(
          state.copyWith(
            status: HandleStatus.error,
            error: LocaleKeys.organization_duplicated.tr(),
          ),
        );
      } else {
        emit(state.copyWith(status: HandleStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: HandleStatus.error));
    }
  }
}
