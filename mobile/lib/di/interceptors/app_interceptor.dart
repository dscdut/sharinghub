import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/hive_keys.dart';

class AppInterceptor extends QueuedInterceptor {
  AppInterceptor({
    @Named(HiveKeys.userBox) required Box userBox,
  }) : _userBox = userBox;

  final Box _userBox;
  // final Dio _dio = Dio();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log('REQUEST[${options.method}] => PATH: ${options.path}');

    // _checkTokenExpired();

    final String? accessToken = _userBox.get(HiveKeys.accessToken);

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
      name: 'Intercepter: onResponse',
    );

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // if (err.response?.statusCode == 401) {

    //   return;
    // }

    log(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      name: 'Intercepter: onError',
    );

    return handler.next(err);
  }

  // void _checkTokenExpired() {
  //   final String? expiredTime = _authBox.get(HiveKeys.expiresIn);

  //   if (expiredTime != null &&
  //       DateTime.parse(expiredTime)
  //           .isBefore(DateTime.now().add(const Duration(seconds: 3)))) {
  //     _refreshToken();
  //   }
  // }

  // Future<void> _refreshToken() async {
  //   final String? refreshToken = _authBox.get(HiveKeys.accessToken);

  //   if (refreshToken == null || refreshToken.isEmpty) {
  //     // TODO: navigate to login screen

  //     return;
  //   }

  //   log('--[REFRESH TOKEN]--: $refreshToken');

  //   try {
  //     final Response response = await _dio.get('');

  //     final RefreshTokenDTO refreshTokenDTO =
  //         RefreshTokenDTO.fromJson(response.data);

  //     await Future.wait([
  //       _userLocalDataSource.saveAccessToken(refreshTokenDTO.accessToken),
  //       _userLocalDataSource.saveRefreshToken(refreshTokenDTO.refreshToken),
  //       _userLocalDataSource.saveExpiresIn(refreshTokenDTO.expiresIn)
  //     ]);
  //   } catch (err) {
  //     // TODO: logout
  //   }
  // }
}
