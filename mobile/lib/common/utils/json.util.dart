import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

class JsonSerializableDateTime implements JsonConverter<DateTime, String> {
  const JsonSerializableDateTime();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime date) => date.toIso8601String();
}

class JsonSerializableMultipartFile
    implements JsonConverter<MultipartFile, MultipartFile> {
  const JsonSerializableMultipartFile();

  @override
  MultipartFile fromJson(MultipartFile json) {
    throw UnimplementedError();
  }

  @override
  MultipartFile toJson(MultipartFile object) => object;
}
