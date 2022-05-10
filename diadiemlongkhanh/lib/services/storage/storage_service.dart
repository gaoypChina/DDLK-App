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

  Future<bool> saveKeyWords(String value) async {
    List<String> currentList = await getKeyWords() ?? [];
    currentList.add(value);
    return shared.setStringList('key_words', currentList);
  }

  Future<List<String>?> getKeyWords() async {
    return shared.getStringList('key_words');
  }
}
