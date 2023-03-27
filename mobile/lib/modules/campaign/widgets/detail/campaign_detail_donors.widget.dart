import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/widgets/detail/info_card.widget.dart';
import 'package:mobile/router/app_routes.dart';

class CampaignDetailDonorsWidget extends StatelessWidget {
  const CampaignDetailDonorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        children: [
          _ListDonors(
            title: LocaleKeys.campaign_list_donator.tr(),
            onSeemore: () => Navigator.of(context).pushNamed(
              AppRoutes.campaignDonation,
              arguments: 0,
            ),
            updateTo: LocaleKeys.campaign_update_to.tr(),
          ),
          _ListDonors(
            title: LocaleKeys.campaign_list_volunteer.tr(),
            onSeemore: () => Navigator.of(context).pushNamed(
              AppRoutes.campaignDonation,
              arguments: 1,
            ),
            updateTo: LocaleKeys.campaign_update_to.tr(),
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
  });

  final String phoneNum = '090294309432';
  final String name = 'Hello World2';
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
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name),
                Text(
                  '${phoneNum.substring(0, 3)}***${phoneNum.substring(phoneNum.length - 1)}',
                ),
              ],
            ),
          ),
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
