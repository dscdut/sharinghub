import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/explore/bloc/home/explore.bloc.dart';

class ExploreDropDownWidget extends StatelessWidget {
  const ExploreDropDownWidget({
    super.key,
    required this.sortType,
  });

  final SortType sortType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          LocaleKeys.home_sort_by.tr(),
          style: TextStyles.regularBody14.copyWith(color: ColorStyles.primary1),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton(
            onChanged: (value) => context.read<ExploreBloc>().add(
                  ExploreSortTypeChange(
                    value!,
                  ),
                ),
            value: sortType,
            items: SortType.values.map((e) {
              return DropdownMenuItem<SortType>(
                value: e,
                child: Text(
                  e.name,
                  style: TextStyles.regularBody16
                      .copyWith(color: ColorStyles.primary1),
                ),
              );
            }).toList(),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: ColorStyles.primary1,
            ),
          ),
        ),
      ],
    );
  }
}
