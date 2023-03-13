import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/data/repositories/organization.repository.dart';

part 'organization_management.event.dart';
part 'organization_management.state.dart';

class OrganizationManagementBloc
    extends Bloc<OrganizationManagementEvent, OrganizationManagementState> {
  final OrganizationRepository _organizationRepository;

  OrganizationManagementBloc({
    required OrganizationRepository organizationRepository,
  })  : _organizationRepository = organizationRepository,
        super(const OrganizationManagementState()) {
    on<OrganizationManagementGet>(_onGetOrganizations);
    add(OrganizationManagementGet());
  }

  Future<void> _onGetOrganizations(
    OrganizationManagementGet event,
    Emitter<OrganizationManagementState> emit,
  ) async {
    emit(state.copyWith(status: HandleStatus.loading));

    try {
      final List<OrganizationModel> organizations =
          await _organizationRepository.getOrganizations();

      emit(
        state.copyWith(
          status: HandleStatus.success,
          organizations: organizations,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: HandleStatus.error));
    }
  }
}
