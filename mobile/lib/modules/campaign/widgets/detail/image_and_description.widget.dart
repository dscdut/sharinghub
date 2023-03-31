import 'package:flutter/material.dart';
import 'package:mobile/common/widgets/app_read_more_text.widget.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/modules/campaign/widgets/detail/info_card.widget.dart';

class ImageAndDescription extends StatelessWidget {
  final String? image;
  final String description;

  const ImageAndDescription({
    super.key,
    this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: image == null
                ? Assets.images.imgDefaultCampaign.image(
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(
            height: 15,
          ),
          AppReadMoreText(
            content: description,
          ),
        ],
      ),
    );
  }
}
