import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/utils/conditional_render.util.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/common/widgets/not_found.widget.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/modules/profile/bloc/organization_profile/organization_profile.bloc.dart';
import 'package:mobile/modules/profile/widgets/organization_profile/body_profile.widget.dart';
import 'package:mobile/modules/profile/widgets/organization_profile/header_profile.widget.dart';

class OrganizationProfilePage extends StatelessWidget {
  final OrganizationModel organization;
  const OrganizationProfilePage({super.key, required this.organization});

  void _listenOrganizationProfileStateChanged(
    BuildContext context,
    OrganizationProfileState state,
  ) {
    if (state.status == HandleStatus.loading) {
      DialogUtil.showLoading(context);
    } else if (state.status == HandleStatus.error) {
      DialogUtil.hideLoading(context);
    } else if (state.status == HandleStatus.success) {
      DialogUtil.hideLoading(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrganizationProfileBloc(
        userRepository: getIt.get<UserRepository>(),
      )..add(OrganizationProfileGet(organization.organizationId)),
      child: BlocListener<OrganizationProfileBloc, OrganizationProfileState>(
        listener: _listenOrganizationProfileStateChanged,
        child: const _OrganizationProfileView(),
      ),
    );
  }
}

class _OrganizationProfileView extends StatefulWidget {
  const _OrganizationProfileView();

  @override
  State<_OrganizationProfileView> createState() =>
      _OrganizationProfileViewState();
}

class _OrganizationProfileViewState extends State<_OrganizationProfileView> {
  final double _rating = 3;

  final Map<HandleStatus?, Widget Function(BuildContext)> _caseBuilers = {
    HandleStatus.loading: (_) => const Center(
          child: CupertinoActivityIndicator(),
        ),
    HandleStatus.error: (_) => const Center(child: NotFound()),
    HandleStatus.initial: (_) => const Center(child: NotFound()),
  };

  final Widget heightSpace = const SizedBox(height: 25);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationProfileBloc, OrganizationProfileState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              AppSize.horizontalSpace,
              AppSize.topSpace + context.paddingTop,
              AppSize.horizontalSpace,
              context.paddingBottom,
            ),
            child:
                BlocBuilder<OrganizationProfileBloc, OrganizationProfileState>(
              builder: (context, state) {
                return ConditionalRenderUtil.single(
                  context,
                  value: state.status,
                  caseBuilders: _caseBuilers,
                  fallbackBuilder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderProfile(
                          rating: _rating,
                          organization: state.organization!,
                        ),
                        heightSpace,
                        const Divider(
                          color: Color(0xFFABB0BC),
                          thickness: 1,
                        ),
                        heightSpace,
                        BodyProfile(
                          organization: state.organization!,
                          heightSpace: heightSpace,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
