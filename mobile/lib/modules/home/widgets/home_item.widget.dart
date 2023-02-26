import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/custom_divider.widget.dart';
import 'package:mobile/data/models/home_module/home_project.model.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
    required this.item,
  });

  final HomeProjectModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Image.network(
              item.imageURL,
              height: 170,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          const CustomDivider(
            length: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyles.boldBody16
                    .copyWith(color: ColorStyles.zodiacBlue),
              ),
              const Divider(
                height: 4,
                color: Colors.transparent,
              ),
              Text(
                item.orgName,
                style: TextStyles.s14MediumText,
              ),
              const Divider(
                height: 4,
                color: Colors.transparent,
              ),
              Text(
                item.orgName,
                style: TextStyles.s14MediumText,
              ),
              const Divider(
                height: 4,
                color: Colors.transparent,
              ),
              Text(
                item.orgName,
                style: TextStyles.s14MediumText,
              ),
            ],
          )
        ],
      ),
    );
  }
}
