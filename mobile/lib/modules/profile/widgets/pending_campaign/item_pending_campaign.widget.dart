import 'package:flutter/material.dart';
import 'package:mobile/common/extensions/string.extension.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/configs/router/app_routes.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/assets.gen.dart';

class ItemPendingCampaignWidget extends StatelessWidget {
  const ItemPendingCampaignWidget({
    super.key,
    required this.campaign,
  });

  final CampaignModel campaign;

  void _onTap(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.campaignDetail,
      arguments: campaign,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorStyles.secondary1,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            campaign.image.isNullOrEmpty
                ? Assets.images.imgDefaultCampaign.image(
                    height: 100,
                    width: 100,
                  )
                : Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          campaign.image ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaign.name,
                  style: TextStyles.boldSubti18.copyWith(
                    color: ColorStyles.primary1,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  campaign.organizationName ?? '',
                  style: TextStyles.regularBody14.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 176,
                  child: Text(
                    campaign.address,
                    style: TextStyles.regularBody14.copyWith(
                      color: ColorStyles.disableColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
