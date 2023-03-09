import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class SearchInputWidget extends StatefulWidget {
  const SearchInputWidget({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      textController: widget.searchController,
      hintText: LocaleKeys.search_search_input_placeholder.tr(),
      borderColor: ColorStyles.primary1,
      focusedBorderColor: ColorStyles.primary1,
      extendField: false,
    );
  }
}
