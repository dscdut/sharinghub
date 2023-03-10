import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/data/datasources/campaign.mock.dart';
import 'package:mobile/modules/campaign/view/campaign_detail.view.dart';
import 'package:mobile/modules/core/bloc/root.bloc.dart';
import 'package:mobile/modules/core/widgets/app_bottom_navigation_bar.widget.dart';
import 'package:mobile/modules/core/widgets/custom_lazy_indexed_stack.widget.dart';
import 'package:mobile/modules/explore/view/explore.view.dart';
import 'package:mobile/modules/management/view/management.view.dart';
import 'package:mobile/modules/map/map.dart';
import 'package:mobile/modules/campaign/view/set_campaign.view.dart';
import 'package:mobile/modules/notification/notification.dart';
import 'package:mobile/modules/profile/profile.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RootBloc(),
      child: const _RootView(),
    );
  }
}

class _RootView extends StatelessWidget {
  const _RootView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RootBloc, RootState>(
        builder: (
          context,
          state,
        ) {
          return SlideIndexedStack(
            index: state.currentIndex,
            children: [
              MapPage(),
              const ExplorePage(),
              const ManagementPage(),
              const NotificationPage(),
              const ProfilePage(),
            ],
          );
        },
        buildWhen: (previous, current) {
          return previous.currentIndex != current.currentIndex;
        },
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
