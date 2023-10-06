import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangePickerSheet extends StatefulWidget {
  final DateTime? initStartDate;
  final DateTime? initEndDate;
  final Function(DateTime startDate, DateTime endDate)? onSubmit;

  const DateRangePickerSheet({
    super.key,
    this.initStartDate,
    this.initEndDate,
    this.onSubmit,
  });

  @override
  State<DateRangePickerSheet> createState() => _DateRangePickerSheetState();
}

class _DateRangePickerSheetState extends State<DateRangePickerSheet> {
  final DateRangePickerController dateRangeController =
      DateRangePickerController();

  bool isValidate = true;

  @override
  void initState() {
    _initDateRange();

    super.initState();
  }

  void _initDateRange() {
    if (widget.initStartDate == null && widget.initEndDate == null) {
      final DateTime today = DateTime.now().add(const Duration(days: 1));
      final DateTime tomorrow = today.add(const Duration(days: 2));

      dateRangeController.selectedRange = PickerDateRange(today, tomorrow);
    } else if (widget.initStartDate != null && widget.initEndDate != null) {
      dateRangeController.selectedRange =
          PickerDateRange(widget.initStartDate, widget.initEndDate);
    }
  }

  void _onSelectionChanged(
    DateRangePickerSelectionChangedArgs dateRangePickerSelectionChangedArgs,
  ) {
    final dynamic dateRangeValue = dateRangePickerSelectionChangedArgs.value;

    setState(() {
      isValidate = dateRangeValue.endDate != null;
    });
  }

  void _onSubmit() {
    final PickerDateRange selectedRange = dateRangeController.selectedRange!;

    Navigator.of(context)
        .pop([selectedRange.startDate!, selectedRange.endDate!]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 1.8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Expanded(
            child: SfDateRangePicker(
              controller: dateRangeController,
              selectionMode: DateRangePickerSelectionMode.range,
              minDate: DateTime.now()..add(const Duration(days: 1)),
              showNavigationArrow: true,
              headerStyle: const DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyles.s17BoldText,
              ),
              startRangeSelectionColor: ColorStyles.primary1,
              endRangeSelectionColor: ColorStyles.primary1,
              selectionTextStyle:
                  TextStyles.s14MediumText.copyWith(color: Colors.white),
              rangeTextStyle: TextStyles.s14MediumText
                  .copyWith(color: ColorStyles.primary1),
              selectionRadius: 20,
              headerHeight: 45,
              monthViewSettings: const DateRangePickerMonthViewSettings(
                showTrailingAndLeadingDates: true,
                firstDayOfWeek: 1,
              ),
              todayHighlightColor: ColorStyles.zodiacBlue,
              onSelectionChanged: _onSelectionChanged,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          AppRoundedButton(
            onPressed: _onSubmit,
            content: LocaleKeys.button_confirm.tr(),
            width: context.width / 2,
            isDisable: !isValidate,
          ),
          SizedBox(
            height: context.paddingBottom + 10,
          ),
        ],
      ),
    );
  }
}
