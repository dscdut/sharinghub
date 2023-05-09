import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/validator.util.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/common/widgets/star_rating.widget.dart';
import 'package:mobile/modules/feedback_individual/feedback_individual.dart';

class FeedbackIndividualForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final int campRate;
  final int orgRate;
  final TextEditingController campEditingController;
  final TextEditingController orgEditingController;
  final void Function(int rating) onCampRateChanged;
  final void Function(int rating) onOrgRateChanged;

  const FeedbackIndividualForm({
    super.key,
    required this.formKey,
    required this.campRate,
    required this.orgRate,
    required this.campEditingController,
    required this.orgEditingController,
    required this.onCampRateChanged,
    required this.onOrgRateChanged,
  });

  final Widget _verticalSpacing = const SizedBox(
    height: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocBuilder<FeedbackIndividualBloc, FeedbackIndividualState>(
        builder: (context, state) {
          return Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rate the campaign',
                  style: TextStyles.s17MediumText,
                ),
              ),
              _verticalSpacing,
              StarRating(
                rating: campRate,
                size: 40.0,
                onRatingChanged: onCampRateChanged,
              ),
              Visibility(
                visible: state.campaignRateError != null,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      state.campaignRateError ?? '',
                      style: TextStyles.regularText.copyWith(
                        color: Colors.red,
                        fontSize: 13,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              _verticalSpacing,
              AppTextFormField(
                validator: ValidatorUtil.validateRequiredField,
                contentPadding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                textController: campEditingController,
                maxLines: 6,
                labelText: 'Review the campaign',
                extendField: false,
              ),
              _verticalSpacing,
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rate the organization',
                  style: TextStyles.s17MediumText,
                ),
              ),
              _verticalSpacing,
              StarRating(
                rating: orgRate,
                size: 40.0,
                onRatingChanged: onOrgRateChanged,
              ),
              Visibility(
                visible: state.organizationRateError != null,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      state.organizationRateError ?? '',
                      style: TextStyles.regularText.copyWith(
                        color: Colors.red,
                        fontSize: 13,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              _verticalSpacing,
              AppTextFormField(
                validator: ValidatorUtil.validateRequiredField,
                contentPadding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                textController: orgEditingController,
                maxLines: 6,
                labelText: 'Review the organization',
                extendField: false,
              ),
            ],
          );
        },
      ),
    );
  }
}
