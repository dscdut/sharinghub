import 'package:flutter/material.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/modules/profile/widgets/organization_profile/body_profile.widget.dart';
import 'package:mobile/modules/profile/widgets/organization_profile/header_profile.widget.dart';

class OrganizationInfo extends StatelessWidget {
  final OrganizationModel organization;

  const OrganizationInfo({
    super.key,
    required this.organization,
  });

  final Widget _verticalSpacing = const SizedBox(height: 25);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSize.horizontalSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderProfile(
            rating: 3,
            organization: organization,
          ),
          BodyProfile(
            organization: organization,
            heightSpace: _verticalSpacing,
          ),
        ],
      ),
    );
  }
}
