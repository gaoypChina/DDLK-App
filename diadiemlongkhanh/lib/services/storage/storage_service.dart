import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  SharedPreferences shared;
  StorageService(this.shared);

  setFirstInstall(bool isFirst) async {
    return shared.setBool('is_first', isFirst);
  }

  bool? getFirstInstall() {
    return shared.getBool('is_first');
  }

  Future<bool> saveToken(String token) async {
    return shared.setString('token', token);
  }

  String? getToken() {
    return shared.getString('token');
  }

  Future<bool> saveKeyWords(String value) async {
    List<String> currentList = await getKeyWords() ?? [];
    if (!currentList.contains(value)) {
      if (currentList.length > 10) {
        currentList.removeLast();
      }
      currentList.insert(0, value);
    }

    return shared.setStringList('key_words', currentList);
  }

  deleteKeyWord(String value) async {
    List<String> currentList = await getKeyWords() ?? [];
    final index = currentList.indexOf(value);
    if (index != -1) {
      currentList.removeAt(index);
    }
    return shared.setStringList('key_words', currentList);
  }

  deleteAllKeyWords() async {
    return shared.remove('key_words');
  }

  Future<bool> savePlaceIds(String id) async {
    List<String> currentList = await getPlaceIds() ?? [];
    if (!currentList.contains(id)) {
      if (currentList.length > 10) {
        currentList.removeLast();
      }
      currentList.insert(0, id);
    }

    return shared.setStringList('place_ids', currentList);
  }

  Future<List<String>?> getKeyWords() async {
    return shared.getStringList('key_words');
  }

  Future<List<String>?> getPlaceIds() async {
    return shared.getStringList('place_ids');
  }

  clear() async {
    await shared.remove('key_words');
    await shared.remove('place_ids');
    await shared.remove('token');
  }
}
