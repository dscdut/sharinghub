import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/hive_keys.dart';

@module
abstract class LocalModule {
  @Named(HiveKeys.userBox)
  @lazySingleton
  @preResolve
  Future<Box> get authBox => Hive.openBox(HiveKeys.userBox);
}
