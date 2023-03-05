import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/home/bloc/home/home.bloc.dart';
import 'package:mobile/modules/home/widgets/home_item.widget.dart';
import 'package:mobile/router/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        repository: getIt.get<CampaignRepository>(),
      ),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {},
        child: const _HomeView(),
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
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
                    style: TextStyles.boldBody14
                        .copyWith(color: ColorStyles.primary1),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: ColorStyles.primary1,
                    size: AppSize.iconSize,
                  ),
                ],
              ),
            ),
            actions: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {},
                  child: const Badge(
                    label: Text('2'),
                    textColor: Colors.white,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.mail_outline,
                      color: ColorStyles.primary1,
                      size: AppSize.iconSize,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(HomeListCampainsGet());
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRoundedButton(
                      width: double.infinity,
                      content: LocaleKeys.home_search.tr(),
                      backgroundColor: ColorStyles.primary1,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.search,
                        );
                      },
                      prefixIcon:
                          Assets.icons.icSearch.image(width: AppSize.iconSize),
                    ),
                    const Divider(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          LocaleKeys.home_sort_by.tr(),
                          style: TextStyles.regularBody14
                              .copyWith(color: ColorStyles.primary1),
                        ),
                        DropdownButton(
                          onChanged: (value) => context.read<HomeBloc>().add(
                                HomeSortTypeChange(
                                  value!,
                                ),
                              ),
                          value: state.sortType,
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
                      ],
                    ),
                    const Divider(
                      height: 10,
                    ),
                    Builder(
                      builder: (context) {
                        if (state.status.isLoading) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (state.status.isSuccess) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                HomeItem(item: state.campaigns![index]),
                            separatorBuilder: (context, index) => const Divider(
                              height: 10,
                              color: Colors.transparent,
                            ),
                            itemCount: state.campaigns!.length,
                          );
                        } else {
                          return const Placeholder();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
