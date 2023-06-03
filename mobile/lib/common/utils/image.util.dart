import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/utils/file.util.dart';

enum ImageType {
  asset,
  file,
  network,
  svg,
  svgNetwork,
}

const List<String> _allowedExtensions = [
  '.png',
  '.jpg',
  '.jpeg',
];

abstract class ImageUtil {
  static ImageType getImageType(String path) {
    switch (FileUtil.getFileExtension(path)) {
      case '.png':
      case '.jpg':
      case '.jepg':
        if (FileUtil.packageInfo != null &&
            path.contains(FileUtil.packageInfo!.packageName)) {
          return ImageType.file;
        } else if (path.startsWith('http')) {
          return ImageType.network;
        } else {
          return ImageType.asset;
        }
      default:
        if (path.startsWith('http')) {
          return ImageType.network;
        }
        return ImageType.asset;
    }
  }

  static Future<File?> cropImage({
    required File imageFile,
    double? width,
    double? height,
    CropStyle cropStyle = CropStyle.rectangle,
  }) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressQuality: 70,
      aspectRatio: CropAspectRatio(ratioX: width ?? 1.0, ratioY: height ?? 1.0),
      compressFormat: ImageCompressFormat.png,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      cropStyle: cropStyle,
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Colors.black,
          toolbarTitle: '',
          hideBottomControls: true,
          toolbarWidgetColor: ColorStyles.primary1,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: '',
          aspectRatioLockEnabled: true,
          hidesNavigationBar: true,
          rotateButtonsHidden: true,
          rotateClockwiseButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
          resetButtonHidden: true,
        ),
      ],
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }

  static Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    return pickedFile == null
        ? null
        : _allowedExtensions
                .contains(FileUtil.getFileExtension(pickedFile.path))
            ? File(pickedFile.path)
            : null;
  }

  static Future<List<File>?> pickMultipleImage() async {
    final pickedFiles = await ImagePicker().pickMultiImage();

    return pickedFiles.isEmpty
        ? null
        : pickedFiles
            .where(
              (pickedFile) => _allowedExtensions
                  .contains(FileUtil.getFileExtension(pickedFile.path)),
            )
            .map((pickedFile) => File(pickedFile.path))
            .toList();
  }

  static Future<File?> pickAndCropImage(
    ImageSource source, {
    double? width,
    double? height,
    CropStyle cropStyle = CropStyle.rectangle,
  }) async {
    final File? pickedImage = await pickImage(source);

    return pickedImage == null
        ? null
        : await cropImage(
            imageFile: pickedImage,
            width: width,
            height: height,
            cropStyle: cropStyle,
          );
  }
}
