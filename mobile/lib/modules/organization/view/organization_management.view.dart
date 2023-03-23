import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/utils/conditional_render.util.dart';
import 'package:mobile/common/widgets/loading_dot.widget.dart';
import 'package:mobile/common/widgets/common_error.widget.dart';
import 'package:mobile/data/repositories/organization.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/organization/bloc/management/organization_management.bloc.dart';
import 'package:mobile/modules/organization/widgets/management/add_organization_fab.widget.dart';
import 'package:mobile/modules/organization/widgets/management/list_organization.widget.dart';
import 'package:mobile/modules/organization/widgets/management/organization_management_app_bar.widget.dart';
import 'package:mobile/router/app_routes.dart';

class OrganizationManagementPage extends StatelessWidget {
  const OrganizationManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrganizationManagementBloc(
        organizationRepository: getIt.get<OrganizationRepository>(),
      ),
      child: const _OrganizationManagementView(),
    );
  }
}

class _OrganizationManagementView extends StatelessWidget {
  const _OrganizationManagementView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OrganizationManagementAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.horizontalSpace,
        ),
        child: BlocBuilder<OrganizationManagementBloc,
            OrganizationManagementState>(
          builder: (context, state) {
            return ConditionalRenderUtil.single(
              context,
              value: state.status,
              caseBuilders: {
                HandleStatus.loading: (_) => const LoadingDot(
                      dotColor: ColorStyles.zodiacBlue,
                    ),
                HandleStatus.initial: (_) => const SizedBox(),
              },
              fallbackBuilder: (_) {
                if (state.organizations.isEmpty) {
                  return CommonError(
                    action: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.setOrganization,
                        arguments: ArgumentWrapper2(
                          param1: null,
                          param2: context.read<OrganizationManagementBloc>(),
                        ),
                      );
                    },
                    title: LocaleKeys.organization_list_empty.tr(),
                    labelAction: LocaleKeys.button_create.tr(),
                  );
                }

                return ListOrganization(organizations: state.organizations);
              },
            );
          },
        ),
      ),
      floatingActionButton: const AddOrganizationFAB(),
      backgroundColor: Colors.white,
    );
  }
}
