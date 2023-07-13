import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/datasources/user.mock.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/widgets/detail/info_card.widget.dart';
import 'package:mobile/configs/router/app_routes.dart';

class CampaignDetailDonorsWidget extends StatelessWidget {
  CampaignDetailDonorsWidget({super.key});

  final List<UserModel> _listDonors = UserMock.getRandomUser(20);
  final List<UserModel> _listVolunteers = UserMock.getRandomUser(16);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        children: [
          _ListDonors(
            title: LocaleKeys.campaign_list_donator.tr(),
            onSeemore: () => Navigator.of(context).pushNamed(
              AppRoutes.campaignDonation,
              arguments:
                  ArgumentWrapper3<int, List<UserModel>, List<UserModel>>(
                param1: 0,
                param2: _listDonors,
                param3: _listVolunteers,
              ),
            ),
            updateTo: LocaleKeys.campaign_update_to.tr(),
            users: _listDonors,
          ),
          _ListDonors(
            title: LocaleKeys.campaign_list_volunteer.tr(),
            onSeemore: () => Navigator.of(context).pushNamed(
              AppRoutes.campaignDonation,
              arguments:
                  ArgumentWrapper3<int, List<UserModel>, List<UserModel>>(
                param1: 1,
                param2: _listDonors,
                param3: _listVolunteers,
              ),
            ),
            updateTo: LocaleKeys.campaign_update_to.tr(),
            users: _listVolunteers,
          ),
        ],
      ),
    );
  }
}

class _ListDonors extends StatelessWidget {
  const _ListDonors({
    required this.title,
    required this.updateTo,
    required this.onSeemore,
    required this.users,
  });

  final List<UserModel> users;
  final String title;
  final String updateTo;
  final Function onSeemore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.boldSubti18,
        ),
        const Divider(
          height: 4,
          color: Colors.transparent,
        ),
        Text(
          updateTo,
          style: TextStyles.regularBody14.copyWith(
            color: ColorStyles.disableColor,
          ),
        ),
        const Divider(
          height: 8,
          color: Colors.transparent,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            UserModel user = users[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(user.fullName),
                  Text(
                    user.phoneNumber ?? '',
                  ),
                ],
              ),
            );
          },
          itemCount: 3,
          primary: false,
        ),
        Center(
          child: MaterialButton(
            onPressed: () => onSeemore(),
            child: Text(
              LocaleKeys.texts_read_more.tr(),
            ),
          ),
        ),
      ],
    );
  }
}
