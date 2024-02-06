import 'package:shared_preferences/shared_preferences.dart';

class MagicSharedPreferences {
  SharedPreferences? _preferences;

  MagicSharedPreferences._();

  static final MagicSharedPreferences _instance = MagicSharedPreferences._();

  static MagicSharedPreferences get instance => _instance;

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

  Future<void> savePassedCharactersId(List<String> passedCharactersIds) async =>
      (await pref).setStringList('passedCharacters', passedCharactersIds);

  Future<List<String>> getPassedCharacters() async =>
      (await pref).getStringList('passedCharacters') ?? [];
}
