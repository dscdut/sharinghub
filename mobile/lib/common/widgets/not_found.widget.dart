import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class NotFound extends StatelessWidget {
  final String? title;

  const NotFound({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Assets.images.notFound.svg(
          width: context.width * 1 / 2,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          title ?? LocaleKeys.texts_error_occur.tr(),
          style: TextStyles.s14MediumText.copyWith(color: ColorStyles.red400),
        )
      ],
    );
  }
}
