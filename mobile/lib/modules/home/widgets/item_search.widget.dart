import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/models/campaign.model.dart';

class ItemSearchWidget extends StatelessWidget {
  const ItemSearchWidget({
    super.key,
    required this.item,
  });

  final CampaignModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorStyles.primary4,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              if (item.imageURL != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    item.imageURL!,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  width: 120,
                  height: 120,
                  color: ColorStyles.primary1,
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                        '${item.address.specificAddress}, ${item.address.ward}, ${item.address.district}, ${item.address.province}',
                        style: TextStyles.regularCaption12,
                      ),
                      const Divider(
                        height: 4,
                        color: Colors.transparent,
                      ),
                      const Text(
                        'Trường Đại học Bách Khoa Hà Nội',
                        style: TextStyles.regularSubti16,
                      )
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
                    item.description,
                    style: TextStyles.regularCaption12,
                    maxLines: 3,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
