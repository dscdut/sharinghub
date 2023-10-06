import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/configs/router/app_routes.dart';

class ItemSearchWidget extends StatelessWidget {
  const ItemSearchWidget({
    super.key,
    required this.item,
  });

  final CampaignModel item;
  final double imageSize = 120;

  void _handleOntap(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.campaignDetail,
      arguments: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleOntap(context),
      child: Container(
        decoration: BoxDecoration(
          color: ColorStyles.primary4,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: item.image == null
                      ? Assets.images.imgDefaultCampaignSquare.image(
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          item.image!,
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.cover,
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyles.boldSubti18.copyWith(),
                        ),
                        const Divider(
                          height: 4,
                          color: Colors.transparent,
                        ),
                        Text(
                          'Đang diễn ra',
                          style: TextStyles.regularCaption12
                              .copyWith(color: Colors.green),
                        ),
                        const Divider(
                          height: 4,
                          color: Colors.transparent,
                        ),
                        Text(
                          '${item.specificAddress}, ${item.address}',
                          style: TextStyles.regularCaption12,
                        ),
                        const Divider(
                          height: 4,
                          color: Colors.transparent,
                        ),
                        const Text(
                          'Trường Đại học Bách Khoa Hà Nội',
                          style: TextStyles.regularSubti16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      item.description ?? '',
                      style: TextStyles.regularCaption12,
                      maxLines: 3,
                    ),
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
