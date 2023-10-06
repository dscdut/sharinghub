import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/hive_keys.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:mobile/data/models/user.model.dart';

@lazySingleton
class UserLocalDataSource {
  final Box _userBox;

  UserLocalDataSource({
    @Named(HiveKeys.userBox) required Box userBox,
  }) : _userBox = userBox;

  UserModel? getUserInfo() {
    final String? rawData = _userBox.get(HiveKeys.user);

    if (rawData == null) {
      return null;
    } else {
      return UserModel.fromJson(Map<String, dynamic>.from(jsonDecode(rawData)));
    }
  }

  Future<void> setUserInfo(UserModel user) async {
    await _userBox.put(HiveKeys.user, jsonEncode(user));
  }

  Future<void> setUserAuthInfo(LoginResponseDTO? response) async {
    if (response == null) {
      await _userBox.clear();
    } else {
      await Future.wait([
        _userBox.put(HiveKeys.accessToken, response.accessToken),
        _userBox.put(HiveKeys.user, jsonEncode(response.user)),
      ]);
    }
  }
}
