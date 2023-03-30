import 'package:flutter/material.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/router/app_routes.dart';

class CampaignItem extends StatelessWidget {
  final CampaignModel currentCampaign;

  const CampaignItem({
    super.key,
    required this.currentCampaign,
  });

  final double height = 65;

  void _navigateToDetail(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.campaignDetail,
      arguments: currentCampaign,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToDetail(context);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: context.width,
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                height,
              ),
              child: Image.network(
                currentCampaign.image!,
                width: height,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          currentCampaign.name,
                          style: TextStyles.s14MediumText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 1.6,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        color: ColorStyles.gray400,
                      ),
                      Text(
                        currentCampaign.statusContent,
                        style: TextStyles.s14MediumText.copyWith(
                          color: currentCampaign.isOngoing
                              ? ColorStyles.green400
                              : ColorStyles.red400,
                        ),
                      )
                    ],
                  ),
                  Text(
                    currentCampaign.organizationName,
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
