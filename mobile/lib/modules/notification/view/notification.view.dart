import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/data/datasources/notification.mock.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/modules/notification/notification.dart';
import 'package:mobile/modules/notification/widgets/list_noti.widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    super.key,
    required this.initIndex,
  });

  final int initIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationBloc(),
      child: BlocListener<NotificationBloc, NotificationState>(
        listener: _onListener,
        child: _NotificationView(
          initIndex: initIndex,
        ),
      ),
    );
  }

  void _onListener(
    BuildContext context,
    NotificationState state,
  ) {}
}

class _NotificationView extends StatefulWidget {
  const _NotificationView({
    required this.initIndex,
  });

  final int initIndex;

  @override
  State<_NotificationView> createState() => __NotificationView();
}

class __NotificationView extends State<_NotificationView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<dynamic> listAllNotis = NotificationMock.listAllNotis;
  final List<dynamic> listUnreadNotis = NotificationMock.listUnreadNotis;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.initIndex,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.root_notification.tr(),
        toolbarHeight: kToolbarHeight + 40,
        bottom: TabBar(
          tabs: [
            Tab(text: LocaleKeys.notification_all.tr()),
            Tab(text: LocaleKeys.notification_unread.tr()),
          ],
          indicatorColor: ColorStyles.zodiacBlue,
          labelColor: ColorStyles.zodiacBlue,
          controller: _tabController,
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state.status == HandleStatus.loading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListNotiWidget(
                    notis: listAllNotis,
                  ),
                  ListNotiWidget(
                    notis: listUnreadNotis,
                  ),
                ],
              ),
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
