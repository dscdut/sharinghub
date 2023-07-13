import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/app_read_more_text.widget.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/modules/campaign/widgets/detail/info_card.widget.dart';

class ImageAndDescription extends StatefulWidget {
  final String? image;
  final String description;

  const ImageAndDescription({
    super.key,
    this.image,
    required this.description,
  });

  @override
  State<ImageAndDescription> createState() => _ImageAndDescriptionState();
}

class _ImageAndDescriptionState extends State<ImageAndDescription> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        children: [
          Column(
            children: [
              CarouselSlider.builder(
                itemCount: 4,
                itemBuilder: (
                  BuildContext context,
                  int itemIndex,
                  int pageViewIndex,
                ) =>
                    ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: widget.image == null
                      ? Assets.images.imgDefaultCampaign.image(
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          widget.image!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => GestureDetector(
                    onTap: () => _controller.animateToPage(index),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorStyles.primary1.withOpacity(
                          _current == index ? 0.9 : 0.4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          AppReadMoreText(
            content: widget.description,
          ),
        ],
      ),
    );
  }
}
