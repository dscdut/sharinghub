import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/configs/router/app_routes.dart';
import 'package:mobile/modules/explore/widgets/infor_item_explore.widget.dart';

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
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: ColorStyles.secondary1,
        ),
        child: GestureDetector(
          onTap: () => _handleOntap(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: item.image == null
                    ? Assets.images.imgDefaultCampaign.image(
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        item.image ?? '',
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              const Divider(
                height: 12,
                color: Colors.transparent,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: InforItemExploreWidget(
                  item: item,
                ),
              ),
              const Divider(
                height: 12,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
