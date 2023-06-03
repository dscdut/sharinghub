import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/explore/bloc/search/search.bloc.dart';

class SearchInputWidget extends StatefulWidget {
  const SearchInputWidget({
    super.key,
  });

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      textController: searchController,
      hintText: LocaleKeys.search_search_input_placeholder.tr(),
      borderColor: ColorStyles.primary1,
      extendField: false,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        context.read<SearchBloc>().add(
              SearchKeywordChanged(
                keyword: value,
              ),
            );
      },
      onEditingComplete: () {
        context.read<SearchBloc>().add(
              const SearchListCampainsGet(),
            );
      },
    );
  }
}
