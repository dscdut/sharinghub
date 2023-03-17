import 'package:flutter/material.dart';
import 'package:mobile/common/theme/app_shadow.wiget.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/ellipsis_overflow_text.widget.dart';
import 'package:mobile/generated/assets.gen.dart';

class AvatarInfoCard extends StatelessWidget {
  final String? avatar;
  final String title;
  final String description;
  final VoidCallback onTap;

  const AvatarInfoCard({
    super.key,
    this.avatar,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppShadow.primary,
          color: Colors.white,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: avatar == null
                  ? Assets.images.imgDefautAvatar.image(
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      avatar!,
                      width: 90,
                      height: 90,
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
                    title,
                    style: TextStyles.boldText.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: EllipsisOverflowText(
                      description,
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
