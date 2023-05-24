import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/configs/router/app_routes.dart';

class ExploreItem extends StatelessWidget {
  const ExploreItem({
    super.key,
    required this.item,
  });

  final CampaignModel item;

  void _handleOntap(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.campaignDetail,
      arguments: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => _handleOntap(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Stack(
                children: [
                  item.image == null
                      ? Assets.images.imgDefaultCampaign.image(
                          height: 170,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          item.image ?? '',
                          height: 170,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: ColorStyles.primary1,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Text(
                        item.organizationName ?? '',
                        style: TextStyles.regularBody14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 12,
              color: Colors.transparent,
            ),
            Text(
              item.name,
              style: TextStyles.boldBody16.copyWith(
                color: ColorStyles.zodiacBlue,
              ),
            ),
            const Divider(
              height: 4,
              color: Colors.transparent,
            ),
            Text(
              item.address,
              style: TextStyles.regularBody14.copyWith(
                color: ColorStyles.zodiacBlue,
              ),
            ),
            const Divider(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
