import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/modules/explore/bloc/home/explore.bloc.dart';
import 'package:mobile/modules/explore/widgets/explore_appbar.widget.dart';
import 'package:mobile/modules/explore/widgets/explore_dropdown.widget.dart';
import 'package:mobile/modules/explore/widgets/explore_list_campaign.widget.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExploreBloc(
        repository: getIt.get<CampaignRepository>(),
      ),
      child: BlocListener<ExploreBloc, ExploreState>(
        listener: (context, state) {},
        child: const _ExploreView(),
      ),
    );
  }
}

class _ExploreView extends StatelessWidget {
  const _ExploreView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ExploreAppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ExploreBloc>().add(ExploreListCampainsGet());
          },
          child: BlocBuilder<ExploreBloc, ExploreState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExploreDropDownWidget(
                      sortType: state.sortType!,
                    ),
                    const Divider(
                      height: 10,
                      color: Colors.transparent,
                    ),
                    ExploreListCampaignWidget(
                      status: state.status,
                      campaigns: state.campaigns,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
