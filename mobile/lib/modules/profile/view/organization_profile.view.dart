import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/utils/conditional_render.util.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/common/widgets/loading_dot.widget.dart';
import 'package:mobile/common/widgets/not_found.widget.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/data/repositories/organization.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/modules/profile/bloc/organization_profile/organization_profile.bloc.dart';
import 'package:mobile/modules/profile/widgets/organization_profile/organization_info.widget.dart';

class OrganizationProfilePage extends StatelessWidget {
  final OrganizationModel organization;

  const OrganizationProfilePage({super.key, required this.organization});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrganizationProfileBloc(
        organizationRepository: getIt.get<OrganizationRepository>(),
      )..add(OrganizationProfileGet(organization.id)),
      child: const _OrganizationProfileView(),
    );
  }
}

class _OrganizationProfileView extends StatelessWidget {
  const _OrganizationProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
        backgroundColor: ColorStyles.background,
        elevation: 0.5,
        titleColor: ColorStyles.zodiacBlue,
      ),
      body: BlocBuilder<OrganizationProfileBloc, OrganizationProfileState>(
        builder: (context, state) {
          return ConditionalRenderUtil.single(
            context,
            value: state.status,
            caseBuilders: {
              HandleStatus.loading: (_) => const Center(
                    child: LoadingDot(
                      dotColor: ColorStyles.zodiacBlue,
                    ),
                  ),
              HandleStatus.error: (_) => const Center(child: NotFound()),
              HandleStatus.initial: (_) => const SizedBox()
            },
            fallbackBuilder: (_) {
              return OrganizationInfo(
                organization: state.organization!,
              );
            },
          );
        },
      ),
    );
  }
}
