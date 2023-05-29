import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/custom_dropdown_button.widget.dart';
import 'package:mobile/data/models/address/district.model.dart';
import 'package:mobile/data/models/address/province.model.dart';
import 'package:mobile/data/models/address/ward.model.dart';
import 'package:mobile/data/repositories/address.repository.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/explore/bloc/search/search.bloc.dart';
import 'package:mobile/modules/explore/widgets/search_input.widget.dart';
import 'package:mobile/modules/explore/widgets/search_result.widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(
        campaignRepository: getIt.get<CampaignRepository>(),
        addressRepository: getIt.get<AddressRepository>(),
      ),
      child: BlocListener<SearchBloc, SearchState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) => _listenSearchState(context, state),
        child: const _SearchPage(),
      ),
    );
  }

  void _listenSearchState(BuildContext context, SearchState state) {}
}

class _SearchPage extends StatelessWidget {
  const _SearchPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchInputWidget(),
        backgroundColor: ColorStyles.primary1,
        leadingWidth: 32,
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Divider(
                height: 8,
                color: Colors.transparent,
              ),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${LocaleKeys.search_province.tr()}: ',
                      style: TextStyles.regularBody14
                          .copyWith(color: Colors.black54),
                    ),
                    Expanded(
                      child: CustomDropdownButton(
                        decoration: const BoxDecoration(),
                        hint: Text(
                          LocaleKeys.search_province.tr(),
                          style: TextStyles.regularBody14
                              .copyWith(color: Colors.black54),
                        ),
                        items: state.provinces.isNotEmpty
                            ? state.provinces.map((e) {
                                return DropdownMenuItem<ProvinceModel>(
                                  value: e,
                                  child: Text(
                                    e.provinceName,
                                    style: TextStyles.regularBody14
                                        .copyWith(color: Colors.black54),
                                  ),
                                );
                              }).toList()
                            : [],
                        onChange: (ProvinceModel value) => context
                            .read<SearchBloc>()
                            .add(
                              SearchProvinceSelected(
                                provinceCode: state.provinces.indexOf(value),
                              ),
                            ),
                        color: Colors.black54,
                        value: state.provinceIndex == -1
                            ? null
                            : state.provinces[state
                                .provinceIndex], // null meaning for disable and show hint
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  // District
                  Expanded(
                    child: CustomDropdownButton(
                      hint: Text(
                        LocaleKeys.search_district.tr(),
                        style: TextStyles.regularBody14
                            .copyWith(color: Colors.black54),
                      ),
                      items: state.districts.isNotEmpty
                          ? state.districts.map((e) {
                              return DropdownMenuItem<DistrictModel>(
                                value: e,
                                child: Text(
                                  e.districtName,
                                  style: TextStyles.regularBody14
                                      .copyWith(color: Colors.black54),
                                ),
                              );
                            }).toList()
                          : const [],
                      onChange: (DistrictModel value) =>
                          context.read<SearchBloc>().add(
                                SearchDistrictSelected(
                                  districtCode: state.districts.indexOf(value),
                                ),
                              ),
                      color: Colors.black54,
                      value: state.districtIndex == -1
                          ? null
                          : state.districts[state.districtIndex],
                    ),
                  ),

                  // Ward
                  Expanded(
                    child: CustomDropdownButton(
                      color: Colors.black54,
                      hint: Text(
                        LocaleKeys.search_ward.tr(),
                        style: TextStyles.regularBody14
                            .copyWith(color: Colors.black54),
                      ),
                      items: state.wards.isNotEmpty
                          ? state.wards.map((e) {
                              return DropdownMenuItem<WardModel>(
                                value: e,
                                child: Text(
                                  e.wardName,
                                  style: TextStyles.regularBody14
                                      .copyWith(color: Colors.black54),
                                ),
                              );
                            }).toList()
                          : [],
                      onChange: (value) => context.read<SearchBloc>().add(
                            SearchWardSelected(
                              wardCode: state.wards.indexOf(value),
                            ),
                          ),
                      value: state.wardIndex == -1
                          ? null
                          : state.wards[state.wardIndex],
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 8,
                color: Colors.transparent,
              ),
              const Divider(
                height: 12,
                color: Colors.transparent,
              ),
              SearchResultWidget(
                campaigns: state.campaigns,
                status: state.status,
                onSearch: () {
                  context.read<SearchBloc>().add(
                        const SearchListCampainsGet(),
                      );
                },
              )
            ],
          ),
        ),
        bloc: BlocProvider.of<SearchBloc>(context),
      ),
    );
  }
}
