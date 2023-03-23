import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/data/models/place.model.dart';
import 'package:mobile/data/repositories/place.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/bloc/location_search/location_search.bloc.dart';

class LocationSearchPage extends StatelessWidget {
  const LocationSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          LocationSearchBloc(placeRepository: getIt.get<PlaceRepository>()),
      child: const _LocationSearchView(),
    );
  }
}

class _LocationSearchView extends StatelessWidget {
  const _LocationSearchView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.texts_location_search.tr()),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.horizontalSpace),
        child: Column(
          children: [
            AppTextFormField(
              onChanged: (value) {
                context
                    .read<LocationSearchBloc>()
                    .add(LocationSearchChanged(input: value));
              },
              hintText: LocaleKeys.campaign_ward_district_province.tr(),
            ),
            BlocBuilder<LocationSearchBloc, LocationSearchState>(
              builder: (context, state) {
                return ListView.separated(
                  itemCount: state.places.length,
                  itemBuilder: (_, index) {
                    final PlaceModel currentPlace = state.places[index];

                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(context).pop({
                          'description': currentPlace.description,
                          'place_id': currentPlace.placeId,
                        });
                      },
                      child: SizedBox(
                        height: 25,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            currentPlace.description,
                            style: TextStyles.s14RegularText,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const Divider(
                      thickness: 1.2,
                    );
                  },
                  shrinkWrap: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
