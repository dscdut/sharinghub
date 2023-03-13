import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/ellipsis_overflow_text.widget.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/router/app_routes.dart';

class OrganizationItem extends StatelessWidget {
  final OrganizationModel currentOrganization;

  const OrganizationItem({super.key, required this.currentOrganization});

  void _navigateToDetail(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.organizationProfile,
      arguments: currentOrganization,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToDetail(context);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 2),
              color: Colors.black.withOpacity(0.1),
            )
          ],
          color: Colors.white,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                'https://unihack.gdsc.dev/assets/dsc-dut.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentOrganization.name,
                    style: TextStyles.boldText.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: EllipsisOverflowText(
                      currentOrganization.description ?? '',
                      style: TextStyles.regularText.copyWith(
                        color: ColorStyles.gray400,
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
