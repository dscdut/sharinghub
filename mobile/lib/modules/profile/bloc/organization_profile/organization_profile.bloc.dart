import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/user.repository.dart';

part 'organization_profile.event.dart';
part 'organization_profile.state.dart';

class OrganizationProfileBloc
    extends Bloc<OrganizationProfileEvent, OrganizationProfileState> {
  final UserRepository _userRepository;
  OrganizationProfileBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const OrganizationProfileState()) {
    on<OrganizationProfileGet>(_onGetOrganizationProfile);
  }

  Future<void> _onGetOrganizationProfile(
    OrganizationProfileGet event,
    Emitter<OrganizationProfileState> emitter,
  ) async {
    emitter(state.copyWith(status: HandleStatus.loading));

    try {
      final OrganizationModel organization =
          await _userRepository.getOrganizationInfoById(event.organizationId);
      emitter(
        state.copyWith(
          status: HandleStatus.success,
          organization: organization,
        ),
      );
    } catch (err) {
      emitter(state.copyWith(status: HandleStatus.error));
    }
  }
}
