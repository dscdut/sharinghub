import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/hive_keys.dart';
import 'package:mobile/data/dtos/auth.dto.dart';

@lazySingleton
class UserLocalDataSource {
  final Box _userBox;

  UserLocalDataSource({
    @Named(HiveKeys.userBox) required Box userBox,
  }) : _userBox = userBox;

  String? getAccessToken() {
    return _userBox.get(HiveKeys.accessToken);
  }

  Future<void> setTokens(TokenDTO? tokenDTO) async {
    if (tokenDTO == null) {
      await _userBox.clear();
    } else {
      return await _userBox.putAll(tokenDTO.toLocalJson());
    }
  }
}
