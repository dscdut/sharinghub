import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/conditional_render.util.dart';
import 'package:mobile/common/utils/image.util.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class ShowOrPickImage extends StatefulWidget {
  final dynamic image;
  final double width;
  final double height;
  final double borderRadius;
  final CropStyle cropStyle;
  final Function(File)? setImage;
  final String? error;

  const ShowOrPickImage({
    super.key,
    this.image,
    required this.width,
    required this.height,
    this.borderRadius = 10,
    this.cropStyle = CropStyle.rectangle,
    required this.setImage,
    this.error,
  });

  @override
  State<ShowOrPickImage> createState() => _ShowOrPickImageState();
}

class _ShowOrPickImageState extends State<ShowOrPickImage> {
  late dynamic image;

  @override
  void initState() {
    image = widget.image;
    super.initState();
  }

  Future<void> _pickImage(ImageSource imageSource) async {
    final File? file = await ImageUtil.pickAndCropImage(
      imageSource,
      width: widget.width,
      height: widget.height,
      cropStyle: widget.cropStyle,
    );

    _closeBottomSheet();

    if (file != null) {
      setState(() {
        image = file;
      });

      await widget.setImage?.call(file);
    }
  }

  void _closeBottomSheet() {
    Navigator.of(context).pop();
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

  ImageType? _getImageType() {
    if (image == null) {
      return null;
    }

    return image is File ? ImageType.file : ImageType.network;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onImageTap(context);
      },
      child: Column(
        children: [
          Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: ColorStyles.gray100,
            ),
            child: ConditionalRenderUtil.single(
              context,
              value: _getImageType(),
              caseBuilders: {
                ImageType.network: (_) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: Image.network(
                      widget.image!,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                ImageType.file: (_) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              },
              fallbackBuilder: (_) => Center(
                child: Icon(
                  Icons.add_photo_alternate_rounded,
                  size: widget.height * 1 / 3,
                  color: ColorStyles.gray300,
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.error != null,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  widget.error ?? '',
                  style: TextStyles.regularText
                      .copyWith(color: Colors.red, fontSize: 13, height: 0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
