import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobile/common/utils/file.util.dart';

class HttpRequestResponse<T> {
  HttpRequestResponse({
    this.body,
    this.headers,
    this.request,
    this.statusCode,
    this.statusMessage,
    this.extra,
  });

  T? body;
  Headers? headers;
  RequestOptions? request;
  int? statusCode;
  String? statusMessage;
  Map<String, dynamic>? extra;
}

class DioHelper {
  final Dio _dio;

  DioHelper({required Dio dio}) : _dio = dio;

  Future<FormData> _mapToFormData(Map<String, dynamic> map) async {
    for (var item in map.entries) {
      if (item.value is File) {
        map[item.key] = await FileUtil.toMultipartFile(item.value);
      }
    }

    final formData = FormData.fromMap(map);
    final FormData newData = FormData();

    for (var element in formData.fields) {
      newData.fields.add(MapEntry(element.key, element.value));
    }

    for (var element in formData.files) {
      if (element.key.contains('[') || element.key.contains(']')) {
        final newKey =
            element.key.replaceAllMapped(RegExp('([+[a-zA-Z]+])'), (m) {
          return '${m[0]}'.replaceAll('[', '.').replaceAll(']', '');
        });
        final newValue = element.value;
        final newEntry = MapEntry(newKey, newValue);
        newData.files.add(newEntry);
      } else {
        newData.files.add(element);
      }
    }

    return newData;
  }

  Future<HttpRequestResponse> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final Response response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );

    return HttpRequestResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  Future<HttpRequestResponse> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? formData,
    Function(int count, int total)? onSendProgress,
  }) async {
    if (formData != null) {
      data = await _mapToFormData(formData);
    }

    final Response response = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
      options: options,
    );

    return HttpRequestResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  Future<HttpRequestResponse> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? formData,
  }) async {
    final Response response = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return HttpRequestResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  Future<HttpRequestResponse> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final Response response = await _dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return HttpRequestResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }
}
