import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/common/widgets/avatar_info_card.widget.dart';
import 'package:mobile/modules/auth/auth.dart';

class ListOrganization extends StatelessWidget {
  final List<OrganizationModel> organizations;

  const ListOrganization({
    super.key,
    required this.organizations,
  });

  void _switchToOrganizationMode(
    BuildContext context,
    OrganizationModel organization,
  ) {
    context.read<AuthBloc>().add(AuthModeSwitch(organization));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: AppSize.horizontalSpace),
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        final OrganizationModel currentOrganization = organizations[index];

        return AvatarInfoCard(
          avatar: currentOrganization.avatar,
          description: currentOrganization.description,
          title: currentOrganization.name,
          onTap: () {
            _switchToOrganizationMode(context, currentOrganization);
          },
        );
      },
      separatorBuilder: (_, __) {
        return const SizedBox(
          height: 10,
        );
      },
      shrinkWrap: true,
      itemCount: organizations.length,
    );
  }
}
