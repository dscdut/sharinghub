import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

abstract class FileUtil {
  static String? applicationDir;
  static PackageInfo? packageInfo;

  static Future<void> getApplicationDir() async {
    applicationDir ??= (await getApplicationSupportDirectory()).path;
    packageInfo = await PackageInfo.fromPlatform();
  }

  static String getFileExtension(String fileName) {
    return '.${fileName.split('.').last}';
  }

  static String getMimeType(String path) {
    return lookupMimeType(path).toString();
  }

  static MediaType getMediaType(File file) {
    return MediaType.parse(getMimeType(file.path));
  }

  static Future<MultipartFile> toMultipartFile(File file) async {
    return await MultipartFile.fromFile(
      file.path,
      filename: basename(file.path),
      contentType: getMediaType(file),
    );
  }
}
