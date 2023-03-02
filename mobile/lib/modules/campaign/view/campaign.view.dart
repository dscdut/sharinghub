import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/modules/campaign/campaign.dart';
import 'package:mobile/router/app_routes.dart';

class CampaignPage extends StatefulWidget {
  final CampaignModel? campaign;

  const CampaignPage({
    super.key,
    this.campaign,
  });

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
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
        isConfirmDialog: true,
        content: widget.campaign == null
            ? 'Tạo dự án thành công'
            : 'Cập nhật dự án thành công',
        confirmButtonText: 'Tạo dự án mới',
        confirmAction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.setCampaign,
            arguments: null,
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
        child: _CampaignView(widget.campaign),
      ),
    );
  }
}

class _CampaignView extends StatefulWidget {
  final CampaignModel? campaign;

  const _CampaignView(this.campaign);

  @override
  State<_CampaignView> createState() => _CampaignViewState();
}

class _CampaignViewState extends State<_CampaignView> {
  bool isChecked = false;

  final UserRepository _userRepository = getIt.get<UserRepository>();

  late UserModel user;
  Future<void> _getUserInfo() async {
    user = await _userRepository.getUserInfo();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final String _province = '';
  final String _district = '';
  final String _ward = '';
  final TextEditingController _specificAddressController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _registerLinkController = TextEditingController();
  final TextEditingController _otherInfoController = TextEditingController();
  final TextEditingController _actifactRequirementController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignBloc, CampaignState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.campaign == null ? 'Tạo dự án mới' : 'Chỉnh sửa dự án',
              style: TextStyles.mediumText.copyWith(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            leading: BackButton(
              color: const Color(0xFF62877A),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
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
                    CampaignForm(
                      formKey: _formKey,
                      userRepository: _userRepository,
                      getUserInfo: _getUserInfo,
                      nameController: _nameController,
                      descriptionController: _descriptionController,
                      province: _province,
                      district: _district,
                      ward: _ward,
                      specificAddressController: _specificAddressController,
                      startDateController: _startDateController,
                      endDateController: _endDateController,
                      registerLinkController: _registerLinkController,
                      otherInfoController: _otherInfoController,
                      actifactRequirementController:
                          _actifactRequirementController,
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
