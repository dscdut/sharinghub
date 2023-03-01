import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/common/widgets/app_text_form_field.widget.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/modules/campaign/campaign.dart';
import 'package:mobile/router/app_routes.dart';

class CampaignPage extends StatelessWidget {
  final bool isCreate;

  const CampaignPage({
    super.key,
    required this.isCreate,
  });

  _listenCampaignState(BuildContext context, CampaignState state) {
    if (state.status == HandleStatus.error) {
      DialogUtil.showCustomDialog(
        context,
        title: 'Error',
        content: state.error,
        isConfirmDialog: true,
      );
    } else if (state.status == HandleStatus.success) {
      DialogUtil.showCustomDialog(
        context,
        title: 'Success',
        content: isCreate ? 'Tạo dự án thành công!' : 'Đã cập nhật',
        confirmButtonText: 'Tạo dự án mới',
        confirmAction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.setCampaign,
            arguments: true,
            (route) => route.settings.name == AppRoutes.root,
          );
        },
        cancelButtonText: 'Về trang chủ',
        cancelAction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.root,
            (route) => route.settings.name == AppRoutes.root,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CampaignBloc(
        projectRepository: getIt.get<CampaignRepository>(),
      ),
      child: BlocListener<CampaignBloc, CampaignState>(
        listener: _listenCampaignState,
        child: _CampaignView(isCreate),
      ),
    );
  }
}

class _CampaignView extends StatelessWidget {
  final bool isCreate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _CampaignView(this.isCreate);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignBloc, CampaignState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              isCreate ? 'Tạo dự án mới' : 'Chỉnh sửa dự án',
              style: TextStyles.mediumText.copyWith(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            leading: const BackButton(color: Color(0xFF62877A)),
            backgroundColor: const Color(0xFFDEF5E5),
            elevation: 0,
            actionsIconTheme: const IconThemeData(color: Color(0xFF62877A)),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppSize.horizontalSpace,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 39),
                    Container(
                      height: 155,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 19),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const AppTextFormField(
                            hintText: 'Tên dự án',
                            borderRadius: 10,
                          ),
                          const AppTextFormField(
                            hintText: 'Mô tả',
                            borderRadius: 10,
                          ),
                          Wrap(
                            children: [
                              DropdownButtonFormField(
                                hint: const Text('Tỉnh/Thành phố'),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Đà Nẵng',
                                    child: Text('Đà Nẵng'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Huế',
                                    child: Text('Huế'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Hà Nội',
                                    child: Text('Hà Nội'),
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                              DropdownButtonFormField(
                                hint: const Text('Quận/Huyện'),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Liên Chiểu',
                                    child: Text('Liên Chiểu'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Hải Châu',
                                    child: Text('Hải Châu'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Ba Đình',
                                    child: Text('Ba Đình'),
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                              DropdownButtonFormField(
                                hint: const Text('Phường/Xã'),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Hòa Khánh Bắc',
                                    child: Text('Hòa Khánh Bắc'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Hòa Khánh Nam',
                                    child: Text('Hòa Khánh Bắc'),
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 19),
                          const AppTextFormField(
                            hintText: 'Địa chỉ cụ thể',
                          ),
                          const SizedBox(height: 19),
                          InputDatePickerFormField(
                            fieldHintText: 'Ngày bắt đầu',
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2023),
                          ),
                          const SizedBox(height: 19),
                          InputDatePickerFormField(
                            fieldHintText: 'Ngày kết thúc',
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2023),
                          ),
                          const SizedBox(height: 19),
                          const AppTextFormField(
                            hintText: 'Form đăng kí TNV (nếu có)',
                          ),
                          const SizedBox(height: 19),
                          CheckboxListTile(
                            value: false,
                            onChanged: (value) {},
                            title: const Text(
                              'Dự án có nhận quyên góp bằng hiện vật không?',
                            ),
                          ),
                          const SizedBox(height: 19),
                          const AppTextFormField(
                            hintText: 'Yêu cầu về hiện vật quyên góp',
                          ),
                          const AppTextFormField(
                            hintText: 'Thông tin khác',
                          ),
                          AppRoundedButton(
                            onPressed: () {},
                            content: 'Hoàn thành',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
