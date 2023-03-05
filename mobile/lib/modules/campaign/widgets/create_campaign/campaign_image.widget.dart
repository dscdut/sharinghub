import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/conditional_render.util.dart';
import 'package:mobile/common/utils/image.util.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/bloc/campaign/set_campaign.bloc.dart';

class CampaignImage extends StatefulWidget {
  final String? imagePath;
  final Future<void> Function(File) setCampaignImage;

  const CampaignImage({
    super.key,
    this.imagePath,
    required this.setCampaignImage,
  });

  @override
  State<CampaignImage> createState() => _CampaignImageState();
}

class _CampaignImageState extends State<CampaignImage> {
  late String? imagePath;

  @override
  void initState() {
    imagePath = widget.imagePath;
    super.initState();
  }

  void _closeBottomSheet() {
    Navigator.of(context).pop();
  }

  Future<void> _pickImage(ImageSource imageSource) async {
    final File? file = await ImageUtil.pickAndCropImage(
      imageSource,
      width: context.width,
      height: context.width * (1 / AppSize.campaignAvatarRatio),
    );

    _closeBottomSheet();

    if (file != null) {
      setState(() {
        imagePath = file.path;
      });

      widget.setCampaignImage(file);
    }
  }

  void _onImageTap(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: Text(
              LocaleKeys.texts_upload_photo.tr(),
              style: TextStyles.s17RegularText
                  .copyWith(color: ColorStyles.gray400),
            ),
            actions: [
              CupertinoActionSheetAction(
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.camera),
                    Text(
                      LocaleKeys.texts_camera.tr(),
                      style: TextStyles.s17RegularText,
                    )
                  ],
                ),
                onPressed: () async {
                  await _pickImage(ImageSource.camera);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(LocaleKeys.texts_galerry.tr()),
                onPressed: () async {
                  await _pickImage(ImageSource.gallery);
                },
              ),
            ],
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        isScrollControlled: true,
        builder: (context) {
          return Wrap(
            alignment: WrapAlignment.center,
            children: [
              Icon(
                Icons.remove,
                color: Colors.grey[600],
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                ),
                title: Text(
                  LocaleKeys.texts_camera.tr(),
                  style: TextStyles.s17RegularText,
                ),
                onTap: () async {
                  await _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: Text(
                  LocaleKeys.texts_galerry.tr(),
                  style: TextStyles.s17RegularText,
                ),
                onTap: () async {
                  await _pickImage(ImageSource.gallery);
                },
              ),
              SizedBox(
                height: context.paddingBottom,
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onImageTap(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: (context.width - 2 * AppSize.horizontalSpace) *
                (1 / AppSize.campaignAvatarRatio),
            width: (context.width - 2 * AppSize.horizontalSpace),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorStyles.gray100,
            ),
            child: ConditionalRenderUtil.single(
              context,
              value:
                  imagePath == null ? null : ImageUtil.getImageType(imagePath!),
              caseBuilders: {
                ImageType.network: (_) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.imagePath!,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                ImageType.file: (_) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(imagePath!),
                      fit: BoxFit.cover,
                    ),
                  );
                }
              },
              fallbackBuilder: (_) => const Center(
                child: Icon(
                  Icons.add_photo_alternate_rounded,
                  size: 50,
                  color: ColorStyles.gray300,
                ),
              ),
            ),
          ),
          BlocBuilder<SetCampaignBloc, SetCampaignState>(
            builder: (context, state) {
              return Visibility(
                visible: state.imageError != null,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    state.imageError ?? '',
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
