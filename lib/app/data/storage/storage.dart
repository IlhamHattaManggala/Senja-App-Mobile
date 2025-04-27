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
}
