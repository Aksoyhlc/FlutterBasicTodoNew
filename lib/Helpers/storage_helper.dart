import 'package:get_storage/get_storage.dart';

class StorageHelper {
  final box = GetStorage();

  Future write(String key, dynamic value) async {
    await box.write(key, value);
  }

  Future<dynamic> read(String key) async {
    return await box.read(key);
  }

  Future delete(String key) async {
    await box.remove(key);
  }
}
