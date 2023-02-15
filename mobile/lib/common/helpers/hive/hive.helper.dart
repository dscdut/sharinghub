import 'package:hive/hive.dart';

abstract class HiveHelper {
  static Future<Box> openBox(String boxName) async {
    return await Hive.openBox(boxName);
  }

  static Future<void> put({
    required String boxName,
    required String keyValue,
    required dynamic value,
  }) async {
    final Box box = await openBox(boxName);
    return await box.put(keyValue, value);
  }

  static Future<void> putAll({
    required String boxName,
    required Map<dynamic, dynamic> value,
  }) async {
    final Box box = await openBox(boxName);
    return await box.putAll(value);
  }

  static Future<dynamic> get({
    required String boxName,
    required String keyValue,
  }) async {
    final Box box = await openBox(boxName);
    return box.get(keyValue);
  }

  static Future<List<dynamic>> getAll({required String boxName}) async {
    final Box box = await openBox(boxName);
    return box.values.toList();
  }

  static Future<Map<dynamic, dynamic>> getBoxMap({
    required String boxName,
  }) async {
    final Box box = await openBox(boxName);

    return box.toMap();
  }

  static Future<void> delete({
    required String boxName,
    required String keyValue,
  }) async {
    final Box box = await openBox(boxName);
    return await box.delete(keyValue);
  }

  static Future<int> clear({required String boxName}) async {
    final Box box = await openBox(boxName);
    return await box.clear();
  }
}
