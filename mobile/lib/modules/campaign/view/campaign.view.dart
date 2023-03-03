import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/common/constants/date_format.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/datasources/user.mock.dart';
import 'package:mobile/data/models/address.model.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/bloc/auth/auth.bloc.dart';
import 'package:mobile/modules/campaign/bloc/campaign/campaign.bloc.dart';
import 'package:mobile/modules/campaign/widgets/campaign_form.widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CampaignBloc(
            campaignRepository: getIt.get<CampaignRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            userRepository: getIt.get<UserRepository>(),
          )..add(AuthUserInfoChecked()),
        ),
      ],
      child: BlocListener<CampaignBloc, CampaignState>(
        listener: _listenCampaignStateChanged,
        child: _CampaignView(widget.campaign),
      ),
    );
  }

  _listenCampaignStateChanged(BuildContext context, CampaignState state) {
    if (state.status == HandleStatus.error) {
      DialogUtil.showCustomDialog(
        context,
        title: LocaleKeys.texts_error.tr(),
        content: state.error,
        isConfirmDialog: true,
      );
    } else if (state.status == HandleStatus.success) {
      DialogUtil.showCustomDialog(
        context,
        title: LocaleKeys.texts_success.tr(),
        isConfirmDialog: true,
        content: widget.campaign == null
            ? LocaleKeys.campaign_create_success.tr()
            : LocaleKeys.campaign_update_success.tr(),
        confirmButtonText: LocaleKeys.campaign_create.tr(),
        confirmAction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.setCampaign,
            (route) => route.settings.name == AppRoutes.root,
          );
        },
        cancelButtonText: LocaleKeys.campaign_back_home.tr(),
        cancelAction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.root,
            (route) => route.settings.name == AppRoutes.root,
          );
        },
      );
    } else if (state.status == HandleStatus.loading) {
      DialogUtil.showLoading(context);
    }
  }
}

class _CampaignView extends StatefulWidget {
  final CampaignModel? campaign;

  const _CampaignView(this.campaign);

  @override
  State<_CampaignView> createState() => _CampaignViewState();
}

class _CampaignViewState extends State<_CampaignView> {
  @override
  void initState() {
    if (widget.campaign != null) {
      _getCampaignInfo();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignBloc, CampaignState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.campaign == null
                  ? LocaleKeys.campaign_create.tr()
                  : LocaleKeys.campaign_edit.tr(),
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
                    GestureDetector(
                      onTap: _onImageTap,
                      child: Container(
                        height: 155,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _imageFile != null
                                ? Image.file(_imageFile!).image
                                : widget.campaign != null
                                    ? NetworkImage(widget.campaign!.imageURL!)
                                    : const NetworkImage(
                                        'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg',
                                      ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF62877A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 19),
                    CampaignForm(
                      isChecked: _isChecked,
                      formKey: _formKey,
                      province: _province,
                      district: _district,
                      ward: _ward,
                      nameController: _nameController,
                      descriptionController: _descriptionController,
                      specificAddressController: _specificAddressController,
                      startDateController: _startDateController,
                      endDateController: _endDateController,
                      registerLinkController: _registerLinkController,
                      otherInfoController: _otherInfoController,
                      actifactRequirementController:
                          _actifactRequirementController,
                      onStartDateTap: _onStartDateTap,
                      onEndDateTap: _onEndDateTap,
                      onProvinceDropdownChanged: _onProvinceDropdownChanged,
                      onDistrictDropdownChanged: _onDistrictDropdownChanged,
                      onWardDropdownChanged: _onWardDropdownChanged,
                      onArtifactChecked: _onArtifactChecked,
                    ),
                    const SizedBox(height: 19),
                    AppRoundedButton(
                      onPressed: _onCampaignSubmit,
                      content: widget.campaign == null
                          ? LocaleKeys.campaign_finish
                          : LocaleKeys.campaign_update.tr(),
                      backgroundColor: const Color(0xFF8EC3B0),
                    ),
                    const SizedBox(height: 21),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  File? _imageFile;
  String? _imageLink =
      'https://www.angelcharity.org/wp-content/uploads/hero-background.jpg';

  Future _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) return;

      setState(() => _imageFile = File(pickedFile.path));
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  bool _isChecked = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _province = '';
  String _district = '';
  String _ward = '';
  final TextEditingController _specificAddressController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _registerLinkController = TextEditingController();
  final TextEditingController _otherInfoController = TextEditingController();
  final TextEditingController _actifactRequirementController =
      TextEditingController();

  void _getCampaignInfo() {
    _imageLink = widget.campaign!.imageURL;
    _nameController.text = widget.campaign!.name;
    _descriptionController.text = widget.campaign!.description;
    _province = widget.campaign!.address.province;
    _district = widget.campaign!.address.district;
    _ward = widget.campaign!.address.ward;
    _specificAddressController.text = widget.campaign!.address.specificAddress;
    _startDateController.text =
        DateFormat(DateFormatPattern.date).format(widget.campaign!.startDate);
    _endDateController.text =
        DateFormat(DateFormatPattern.date).format(widget.campaign!.endDate);
    _registerLinkController.text = widget.campaign!.registerLink ?? '';
    _isChecked = widget.campaign!.haveArtifactDonate;
    _otherInfoController.text = widget.campaign!.otherInfo ?? '';
    _actifactRequirementController.text =
        widget.campaign!.artifactRequirement ?? '';
  }

  void _onImageTap() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: Text(LocaleKeys.campaign_choose_photo.tr()),
            actions: [
              CupertinoActionSheetAction(
                child: Text(LocaleKeys.campaign_take_photo.tr()),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
              CupertinoActionSheetAction(
                child: Text(LocaleKeys.campaign_choose_photo.tr()),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
            ],
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
            width: 0.3,
          ),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return SizedBox(
            height: context.heightWithSafeArea * 0.23,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        Icons.remove,
                        color: Colors.grey[600],
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.camera_alt,
                        ),
                        title: Text(LocaleKeys.campaign_take_photo.tr()),
                        onTap: () => _pickImage(ImageSource.camera),
                      ),
                      ListTile(
                        leading: const Icon(Icons.image),
                        title: Text(LocaleKeys.campaign_choose_photo.tr()),
                        onTap: () => _pickImage(ImageSource.gallery),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void _onStartDateTap() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _startDateController.text =
          DateFormat(DateFormatPattern.date).format(picked).toString();
    }
  }

  void _onEndDateTap() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          DateFormat(DateFormatPattern.date).parse(_startDateController.text),
      firstDate:
          DateFormat(DateFormatPattern.date).parse(_startDateController.text),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _endDateController.text =
          DateFormat(DateFormatPattern.date).format(picked).toString();
    }
  }

  void _onProvinceDropdownChanged(String? value) {
    setState(() {
      _province = value.toString();
    });
  }

  void _onDistrictDropdownChanged(String? value) {
    setState(() {
      _district = value.toString();
    });
  }

  void _onWardDropdownChanged(String? value) {
    setState(() {
      _ward = value.toString();
    });
  }

  void _onArtifactChecked(bool? value) {
    setState(() {
      _isChecked = value!;
    });
  }

  void _onCampaignSubmit() async {
    if (_formKey.currentState!.validate()) {
      if (!mounted) return;
      context.read<CampaignBloc>().add(
            CampaignSubmit(
              campaign: CampaignModel(
                id: widget.campaign != null ? widget.campaign!.id : null,
                // organization: context.read<AuthBloc>().state.user!,
                organization: UserMock.getOrganization(),
                name: _nameController.text,
                description: _descriptionController.text,
                address: AddressModel(
                  specificAddress: _specificAddressController.text,
                  province: _province,
                  district: _district,
                  ward: _ward,
                ),
                startDate: DateFormat(
                  DateFormatPattern.date,
                ).parse(_startDateController.text),
                endDate: DateFormat(
                  DateFormatPattern.date,
                ).parse(_endDateController.text),
                haveArtifactDonate: _isChecked,
                artifactRequirement: _actifactRequirementController.text == ''
                    ? null
                    : _actifactRequirementController.text,
                otherInfo: _otherInfoController.text == ''
                    ? null
                    : _otherInfoController.text,
                registerLink: _registerLinkController.text == ''
                    ? null
                    : _registerLinkController.text,
                imageURL:
                    _imageFile != null ? _imageFile.toString() : _imageLink,
              ),
            ),
          );
    }
  }
}
