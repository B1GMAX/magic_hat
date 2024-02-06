import 'package:shared_preferences/shared_preferences.dart';

class MagicSharedPreferences {
  late SharedPreferences _preferences;

  Future init() async => _preferences = await SharedPreferences.getInstance();



}
