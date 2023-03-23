import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:readmore/readmore.dart';

class AppReadMoreText extends StatelessWidget {
  final String content;
  final String? preText;
  final String? postText;
  final TextStyle? preStyle;
  final TextStyle? postStyle;
  final TextStyle? style;
  final int trimLines;

  const AppReadMoreText({
    super.key,
    this.content = '',
    this.preText,
    this.postText,
    this.preStyle,
    this.postStyle,
    this.style,
    this.trimLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      content,
      preDataText: preText,
      postDataText: postText,
      preDataTextStyle: preStyle ?? TextStyles.regularText,
      postDataTextStyle: postStyle ?? TextStyles.regularText,
      colorClickableText: Colors.pink,
      trimLength: 140,
      trimCollapsedText: LocaleKeys.texts_read_more.tr(),
      trimExpandedText: LocaleKeys.texts_hide_info.tr(),
      style: style ?? TextStyles.regularText,
      lessStyle: TextStyles.s14RegularText.copyWith(color: ColorStyles.blue300),
      moreStyle: TextStyles.s14RegularText.copyWith(color: ColorStyles.blue300),
    );
  }
}
