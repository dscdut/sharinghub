import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobile/common/constants/hive_keys.dart';
import 'package:mobile/common/helpers/hive/hive.helper.dart';
import 'package:mobile/data/dtos/auth.dto.dart';

class DioInterceptor extends QueuedInterceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log('REQUEST[${options.method}] => PATH: ${options.path}');

    await _checkTokenExpired();

    final String? accessToken = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.accessToken,
    );

    if (accessToken != null) {
      options.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );

    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // TODO: logout

      return;
    }

    log(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );

    return handler.next(err);
  }

  Future<void> _checkTokenExpired() async {
    final String? expiredTime = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.expiresIn,
    );

    if (expiredTime != null &&
        DateTime.parse(expiredTime)
            .isBefore(DateTime.now().add(const Duration(seconds: 3)))) {
      _refreshToken();
    }
  }

  Future<void> _refreshToken() async {
    final String? refreshToken = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.refreshToken,
    );

    if (refreshToken == null || refreshToken.isEmpty) {
      // TODO: navigate to login screen
      return;
    }

    log('--[REFRESH TOKEN]--: $refreshToken');

    final Dio tokenDio = Dio();

    try {
      final Response response = await tokenDio.get('');

      final RefreshTokenDTO refreshTokenDTO =
          RefreshTokenDTO.fromJson(response.data);

      // TODO: handle set token to local data source
    } catch (err) {
      // TODO: logout
    }
  }
}
