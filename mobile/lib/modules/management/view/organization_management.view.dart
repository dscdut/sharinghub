import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/utils/conditional_render.util.dart';
import 'package:mobile/common/widgets/loading_dot.widget.dart';
import 'package:mobile/common/widgets/not_found.widget.dart';
import 'package:mobile/data/repositories/organization.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/management/bloc/management/organization_management.bloc.dart';
import 'package:mobile/modules/management/widgets/management/list_organization.widget.dart';
import 'package:mobile/modules/management/widgets/management/management_app_bar.widget.dart';
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
      appBar: const ManagementAppBar(),
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
                  return NotFound(
                    action: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.setOrganization);
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
      floatingActionButton:
          BlocBuilder<OrganizationManagementBloc, OrganizationManagementState>(
        builder: (context, state) {
          return Visibility(
            visible: state.status.isSuccess && state.organizations.isNotEmpty,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.setCampaign);
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
