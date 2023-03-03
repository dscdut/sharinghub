import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/modules/campaign/bloc/campaign/campaign.bloc.dart';
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

  const _CampaignView(this.isCreate);

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
        );
      },
    );
  }
}
