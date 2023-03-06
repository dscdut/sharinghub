import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/modules/profile/bloc/profile_organization/profile_organization.bloc.dart';
import 'package:mobile/modules/profile/widgets/profile_organization/body_profile.widget.dart';
import 'package:mobile/modules/profile/widgets/profile_organization/header_profile.widget.dart';

class ProfileOrganizationPage extends StatelessWidget {
  const ProfileOrganizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileOrganizationBloc(),
      child: BlocListener<ProfileOrganizationBloc, ProfileOrganizationState>(
        listener: (context, state) {},
        child: const _ProfileOrganizationView(),
      ),
    );
  }
}

class _ProfileOrganizationView extends StatefulWidget {
  const _ProfileOrganizationView();

  @override
  State<_ProfileOrganizationView> createState() =>
      _ProfileOrganizationViewState();
}

class _ProfileOrganizationViewState extends State<_ProfileOrganizationView> {
  final double rating = 3;

  final Widget heightSpace = const SizedBox(height: 25);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileOrganizationBloc, ProfileOrganizationState>(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(rating: rating),
                heightSpace,
                const Divider(
                  color: Color(0xFFABB0BC),
                  thickness: 1,
                ),
                heightSpace,
                ProfileBody(
                  heightSpace: heightSpace,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
