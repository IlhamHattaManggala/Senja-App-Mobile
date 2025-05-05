import 'package:get_storage/get_storage.dart';

class Storage {
  final GetStorage _box = GetStorage();

  String? getToken() {
    return _box.read('token');
  }

  Future<void> saveToken(String token) async {
    await _box.write('token', token);
  }

  Future<void> removeToken() async {
    await _box.remove('token');
  }

  String? getApiKey() {
    return _box.read('apikey');
  }

  Future<void> saveApiKey(String apikey) async {
    await _box.write('apikey', apikey);
  }

  Future<void> removeApiKey() async {
    await _box.remove('apikey');
  }
}
