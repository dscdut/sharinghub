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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            height: 20,
            color: Colors.transparent,
          ),
          Text(
            LocaleKeys.campaign_list_donator.tr(),
            style: TextStyles.boldSubti18,
          ),
          const Divider(
            height: 4,
            color: Colors.transparent,
          ),
          Text(
            LocaleKeys.campaign_update_to.tr(),
            style: TextStyles.regularBody14.copyWith(
              color: ColorStyles.disableColor,
            ),
          ),
          const Divider(
            height: 8,
            color: Colors.transparent,
          ),
          const _ListDonors(),
          Center(
            child: MaterialButton(
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.campaignDonation,
                arguments: 0,
              ),
              child: Text(
                LocaleKeys.texts_read_more.tr(),
              ),
            ),
          ),
          const Divider(
            height: 8,
            color: Colors.transparent,
          ),
          Text(
            LocaleKeys.campaign_list_volunteer.tr(),
            style: TextStyles.boldSubti18,
          ),
          const Divider(
            height: 4,
            color: Colors.transparent,
          ),
          Text(
            LocaleKeys.campaign_update_to.tr(),
            style: TextStyles.regularBody14.copyWith(
              color: ColorStyles.disableColor,
            ),
          ),
          const Divider(
            height: 8,
            color: Colors.transparent,
          ),
          const _ListDonors(),
          Center(
            child: MaterialButton(
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.campaignDonation,
                arguments: 1,
              ),
              child: Text(
                LocaleKeys.texts_read_more.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListDonors extends StatelessWidget {
  const _ListDonors();

  final String phoneNum = '090294309432';
  final String name = 'Hello World2';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
