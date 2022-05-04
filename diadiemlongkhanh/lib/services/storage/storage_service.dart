import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  SharedPreferences shared;
  StorageService(this.shared);

  Future<bool> saveToken(String token) async {
    return shared.setString('token', token);
  }

  String? getToken() {
    return shared.getString('token');
  }
}
