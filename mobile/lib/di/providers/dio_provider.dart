import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/hive_keys.dart';
import 'package:mobile/di/interceptors/app_interceptor.dart';

@lazySingleton
class DioProvider {
  Dio? _dio;
  final Box _userBox;

  DioProvider({@Named(HiveKeys.userBox) required Box userBox})
      : _userBox = userBox;

  Dio getDio() => _dio ?? _createDio();

  Dio _createDio() {
    final Dio interceptorDio = Dio();

    final AppInterceptor appInterceptor = AppInterceptor(
      userBox: _userBox,
    );
    final List<Interceptor> interceptors = <Interceptor>[];
    interceptors.add(appInterceptor);

    return interceptorDio
      ..options.connectTimeout = 3000
      ..options.receiveTimeout = 5000
      ..options.headers = {
        HttpHeaders.contentTypeHeader: ContentType.json.value,
      }
      ..interceptors.addAll(interceptors);
  }
}
