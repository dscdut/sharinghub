import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/extensions/date_time.extension.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/bloc/set/set_campaign.bloc.dart';
import 'package:mobile/modules/campaign/widgets/set_campaign/date_range_picker_sheet.widget.dart';

class DateRangePicker extends StatefulWidget {
  final void Function(DateTime, DateTime) setCampaignDateRange;
  final DateTime? startDate;
  final DateTime? endDate;

  const DateRangePicker({
    super.key,
    required this.setCampaignDateRange,
    this.startDate,
    this.endDate,
  });

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  String? startDate;
  String? endDate;

  @override
  void initState() {
    startDate = widget.startDate == null ? null : widget.startDate!.toDisplay;
    endDate = widget.endDate == null ? null : widget.endDate!.toDisplay;
    super.initState();
  }

  Future<void> _showDatePickerSheet(BuildContext context) async {
    final List<DateTime>? dateRange = await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      enableDrag: false,
      builder: (_) {
        return const DateRangePickerSheet();
      },
      isScrollControlled: true,
    );

    _setDateRange(dateRange);
  }

  void _setDateRange(List<DateTime>? dateRange) {
    if (dateRange != null) {
      widget.setCampaignDateRange(dateRange[0], dateRange[1]);

      setState(() {
        startDate = dateRange[0].toDisplay;
        endDate = dateRange[1].toDisplay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _showDatePickerSheet(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: ColorStyles.gray200),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  startDate ?? LocaleKeys.campaign_start_date.tr(),
                  style: TextStyles.s14RegularText.copyWith(
                    color: startDate == null
                        ? ColorStyles.gray200
                        : ColorStyles.zodiacBlue,
                  ),
                ),
                const Icon(
                  Icons.remove,
                  color: ColorStyles.gray200,
                ),
                Text(
                  endDate ?? LocaleKeys.campaign_end_date.tr(),
                  style: TextStyles.s14RegularText.copyWith(
                    color: endDate == null
                        ? ColorStyles.gray200
                        : ColorStyles.zodiacBlue,
                  ),
                )
              ],
            ),
          ),
          BlocBuilder<SetCampaignBloc, SetCampaignState>(
            builder: (context, state) {
              return Visibility(
                visible: state.dateRangeError != null,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    state.dateRangeError ?? '',
                    style: TextStyles.regularText
                        .copyWith(color: Colors.red, fontSize: 13, height: 0),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
