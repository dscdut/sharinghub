import 'package:flutter/material.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';

class ExploreAppbarWidget extends StatelessWidget with PreferredSizeWidget {
  const ExploreAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: ColorStyles.primary1,
              size: AppSize.iconSize,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '193 Nguyen Luong Bang',
              style:
                  TextStyles.boldBody14.copyWith(color: ColorStyles.primary1),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: ColorStyles.primary1,
              size: AppSize.iconSize,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
