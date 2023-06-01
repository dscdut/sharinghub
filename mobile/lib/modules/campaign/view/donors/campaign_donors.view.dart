import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/modules/campaign/bloc/donors/campaign_donors.bloc.dart';
import 'package:mobile/modules/campaign/widgets/donors/list_donors.widget.dart';

class CampaignDonorsPage extends StatelessWidget {
  const CampaignDonorsPage({
    super.key,
    required this.initIndex,
    required this.listDonors,
    required this.listVolunteers,
  });

  final int initIndex;
  final List<UserModel> listDonors;
  final List<UserModel> listVolunteers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CampaignDonorsBloc(),
      child: BlocListener<CampaignDonorsBloc, CampaignDonorsState>(
        listener: _onListener,
        child: _CampaignDonorsView(
          initIndex: initIndex,
          listDonors: listDonors,
          listVolunteers: listVolunteers,
        ),
      ),
    );
  }

  void _onListener(
    BuildContext context,
    CampaignDonorsState state,
  ) {}
}

class _CampaignDonorsView extends StatefulWidget {
  const _CampaignDonorsView({
    required this.initIndex,
    required this.listDonors,
    required this.listVolunteers,
  });

  final int initIndex;
  final List<UserModel> listDonors;
  final List<UserModel> listVolunteers;

  @override
  State<_CampaignDonorsView> createState() => __CampaignDonorsView();
}

class __CampaignDonorsView extends State<_CampaignDonorsView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String title = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.initIndex,
      length: 2,
      vsync: this,
    );
    onChangeTab();
    _tabController.addListener(() {
      onChangeTab();
    });
  }

  void onChangeTab() {
    setState(() {
      title = _tabController.index == 0
          ? LocaleKeys.campaign_list_donator.tr()
          : LocaleKeys.campaign_list_volunteer.tr();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyles.primary1,
        title: Text(title),
        bottom: TabBar(
          tabs: [
            Tab(text: '${LocaleKeys.campaign_donator.tr()}s'),
            Tab(text: '${LocaleKeys.campaign_volunteer.tr()}s'),
          ],
          indicatorColor: Colors.white,
          controller: _tabController,
        ),
      ),
      body: BlocBuilder<CampaignDonorsBloc, CampaignDonorsState>(
        builder: (context, state) {
          if (state.status == HandleStatus.loading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            return TabBarView(
              controller: _tabController,
              children: [
                //donors
                ListDonorsWidget(
                  users: widget.listDonors,
                ),

                //volunteers
                ListDonorsWidget(
                  users: widget.listVolunteers,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
