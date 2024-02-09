import 'dart:convert';

import 'package:magic_hat/model/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  SharedPreferences? _preferences;

  Repository._();

  static final Repository _instance = Repository._();

  static Repository get instance => _instance;

  Future<SharedPreferences> get pref async =>
      _preferences ?? await SharedPreferences.getInstance();

  Future<void> saveTotalValue(int totalValue) async =>
      (await pref).setInt('totalValue', totalValue);

  Future<int> getTotalValue() async => (await pref).getInt('totalValue') ?? 0;

  Future<void> saveSuccessValue(int successValue) async =>
      (await pref).setInt('successValue', successValue);

  Future<int> getSuccessValue() async =>
      (await pref).getInt('successValue') ?? 0;

  Future<void> saveFailedValue(int failedValue) async =>
      (await pref).setInt('failedValue', failedValue);

  Future<int> getFailedValue() async => (await pref).getInt('failedValue') ?? 0;

  Future<void> savePassedCharacters(List<CharacterModel> characters) async {
    final List<String> passedCharacters = [];
    for (final character in characters) {
      passedCharacters.add(jsonEncode(character.toJson()));
    }

    (await pref).setStringList('passedCharacters', passedCharacters);
  }

  Future<List<CharacterModel>> getPassedCharacters() async {
    final List<CharacterModel> characters = [];
    final passedCharacters =
        (await pref).getStringList('passedCharacters') ?? [];

    for (final ph in passedCharacters) {
      characters.add(CharacterModel.fromJson(jsonDecode(ph)));
    }

    return characters;
  }
}
