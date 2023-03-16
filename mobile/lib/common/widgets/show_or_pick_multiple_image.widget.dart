import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/conditional_render.util.dart';
import 'package:mobile/common/utils/image.util.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class ShowOrPickMultipleImage extends StatefulWidget {
  final List<String?>? imagePaths;
  final double width;
  final double height;
  final double borderRadius;
  final CropStyle cropStyle;
  final void Function(List<File>)? setImages;
  final String? error;

  const ShowOrPickMultipleImage({
    super.key,
    this.imagePaths,
    required this.width,
    required this.height,
    this.borderRadius = 10,
    this.cropStyle = CropStyle.rectangle,
    this.setImages,
    this.error,
  });

  @override
  State<ShowOrPickMultipleImage> createState() =>
      _ShowOrPickMultipleImageState();
}

class _ShowOrPickMultipleImageState extends State<ShowOrPickMultipleImage> {
  late List<String?>? imagePaths;

  @override
  void initState() {
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
            imagePaths!
                .addAll(files.take(remaining).map((e) => e.path).toList());
          }
        }
      });

      widget.setImages!(imagePaths!.map((e) => File(e!)).toList());
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
                child: Text(LocaleKeys.texts_galerry.tr()),
                onPressed: () async {
                  _pickMultipleImage();
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
                leading: const Icon(Icons.image),
                title: Text(
                  LocaleKeys.texts_galerry.tr(),
                  style: TextStyles.s17RegularText,
                ),
                onTap: () async {
                  _pickMultipleImage();
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                  width: widget.width / 5,
                  height: widget.height / 5,
                  child: Center(
                    child: Icon(
                      Icons.add_photo_alternate_rounded,
                      size: widget.height * 1 / 7,
                      color: ColorStyles.gray300,
                    ),
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
