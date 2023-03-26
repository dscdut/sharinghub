import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/explore/widgets/item_search.widget.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    super.key,
    required this.campaigns,
    required this.status,
    required this.onSearch,
  });

  final List<CampaignModel>? campaigns;
  final HandleStatus status;
  final Function onSearch;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Builder(
        builder: (context) {
          if (status.isInitial) {
            return Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                LocaleKeys.search_init_placeholder.tr(),
                style: TextStyles.regularHeading20
                    .copyWith(color: ColorStyles.disableColor),
              ),
            );
          } else if (status.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (status.isSuccess && campaigns!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                LocaleKeys.search_empty_result.tr(),
                style: TextStyles.regularHeading20
                    .copyWith(color: ColorStyles.disableColor),
              ),
            );
          } else {
            return RefreshIndicator(
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    ItemSearchWidget(item: campaigns![index]),
                itemCount: campaigns!.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 8,
                  color: Colors.transparent,
                ),
              ),
              onRefresh: () => onSearch(),
            );
          }
        },
      ),
    );
  }
}
