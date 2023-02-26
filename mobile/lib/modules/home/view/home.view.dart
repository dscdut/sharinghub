import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/common/widgets/custom_divider.widget.dart';
import 'package:mobile/data/repositories/project.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/home/bloc/home.bloc.dart';
import 'package:mobile/modules/home/widgets/home_item.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        repository: getIt.get<ProjectRepository>(),
      ),
      child: const _HomeView(),
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
            title: const Center(
              child: Text(
                'Logo App',
                style: TextStyles.s17RegularText,
              ),
            ),
            backgroundColor: Colors.white,
            leading: Center(
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                  size: AppSize.iconSize,
                ),
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
                      color: Colors.black,
                      size: AppSize.iconSize,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppRoundedButton(
                    width: double.infinity,
                    content: LocaleKeys.home_search.tr(),
                    onPressed: () {},
                    prefixIcon:
                        Assets.icons.icSearch.image(width: AppSize.iconSize),
                  ),
                  const Divider(
                    height: 10,
                  ),
                  Builder(
                    builder: (context) {
                      if (state.status.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state.status.isSuccess) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              HomeItem(item: state.items![index]),
                          separatorBuilder: (context, index) =>
                              const CustomDivider(length: 10),
                          itemCount: state.items!.length,
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
        );
      },
    );
  }
}
