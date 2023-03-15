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
  final String? imagePath;
  final List<String?>? imagePaths;
  final double width;
  final double height;
  final double borderRadius;
  final CropStyle cropStyle;
  final void Function(File)? setImage;
  final void Function(List<File>)? setImages;
  final String? error;
  final bool? isMultiplePick;

  const ShowOrPickImage({
    super.key,
    this.imagePath,
    this.imagePaths,
    required this.width,
    required this.height,
    this.borderRadius = 10,
    this.cropStyle = CropStyle.rectangle,
    this.setImage,
    this.setImages,
    this.error,
    this.isMultiplePick = false,
  });

  @override
  State<ShowOrPickImage> createState() => _ShowOrPickImageState();
}

class _ShowOrPickImageState extends State<ShowOrPickImage> {
  late String? imagePath;
  late List<String?>? imagePaths;

  @override
  void initState() {
    imagePath = widget.imagePath;
    imagePaths = widget.imagePaths;
    super.initState();
  }

  void _closeBottomSheet() {
    Navigator.of(context).pop();
  }

  Future<void> _pickMultipleImage() async {
    final List<File>? files = await ImageUtil.pickMultipleImage();

    _closeBottomSheet();

    if (files != null) {
      setState(() {
        if (imagePaths == null) {
          imagePaths = files.take(10).map((e) => e.path).toList();
        } else {
          int remaining = 10 - imagePaths!.length;
          if (remaining > 0) {
            imagePaths!.addAll(files.take(remaining).map((e) => e.path).toList());
          }
        }
      });

      widget.setImages!(imagePaths!.map((e) => File(e!)).toList());
    }
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
        imagePath = file.path;
      });

      widget.setImage!(file);
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
              Visibility(
                visible: !widget.isMultiplePick!,
                child: CupertinoActionSheetAction(
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
              ),
              CupertinoActionSheetAction(
                child: Text(LocaleKeys.texts_galerry.tr()),
                onPressed: () async {
                  !widget.isMultiplePick!
                      ? _pickImage(ImageSource.gallery)
                      : _pickMultipleImage();
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
              Visibility(
                visible: !widget.isMultiplePick!,
                child: ListTile(
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
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: Text(
                  LocaleKeys.texts_galerry.tr(),
                  style: TextStyles.s17RegularText,
                ),
                onTap: () async {
                  !widget.isMultiplePick!
                      ? _pickImage(ImageSource.gallery)
                      : _pickMultipleImage();
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

  Widget _buildImageWidget(Widget child, int index) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: child,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                imagePaths!.removeAt(index);
                widget.setImages!(imagePaths!.map((e) => File(e!)).toList());
              });
            },
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!widget.isMultiplePick!)
          GestureDetector(
            onTap: () {
              _onImageTap(context);
            },
            child: Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: ColorStyles.gray100,
              ),
              child: ConditionalRenderUtil.single(
                context,
                value: imagePath == null
                    ? null
                    : ImageUtil.getImageType(imagePath!),
                caseBuilders: {
                  ImageType.network: (_) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      child: Image.network(
                        widget.imagePath!,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  ImageType.file: (_) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      child: Image.file(
                        File(imagePath!),
                        fit: BoxFit.cover,
                      ),
                    );
                  }
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
          )
        else
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: ((imagePaths?.length ?? 0) + 1).clamp(1, 10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) => Container(
              height: widget.height / 5,
              width: widget.width / 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: ColorStyles.gray100,
              ),
              child: ConditionalRenderUtil.single(
                context,
                value: imagePaths == null || index > imagePaths!.length - 1
                    ? null
                    : ImageUtil.getImageType(imagePaths![index]!),
                caseBuilders: {
                  ImageType.network: (_) {
                    return _buildImageWidget(
                      Image.network(
                        imagePaths![index]!,
                        fit: BoxFit.cover,
                      ),
                      index,
                    );
                  },
                  ImageType.file: (_) {
                    return _buildImageWidget(
                      Image.file(
                        File(imagePaths![index]!),
                        fit: BoxFit.cover,
                      ),
                      index,
                    );
                  },
                },
                fallbackBuilder: (_) => GestureDetector(
                  onTap: () => _onImageTap(context),
                  child: Center(
                    child: Icon(
                      Icons.add_photo_alternate_rounded,
                      size: widget.height * 1 / 5,
                      color: ColorStyles.gray300,
                    ),
                  ),
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
    );
  }
}
