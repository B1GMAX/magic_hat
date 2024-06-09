import 'dart:convert';

import 'package:magic_hat/model/character_model.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApiService {
  final String _api = 'https://hp-api.onrender.com/api';

  Future<List<CharacterModel>> getAllCharacters() async {
    final List<CharacterModel> characters = [];
    final response = await get(Uri.parse('$_api/characters'));
    if (response.statusCode == 200) {
      try {
        final List responseCharacters = jsonDecode(response.body);
        characters.addAll(responseCharacters
            .map((character) => CharacterModel.fromJson(character))
            .toList());
        return characters;
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Something went wrong when loading characters",
        );
      }
    }
    return characters;
  }
}
