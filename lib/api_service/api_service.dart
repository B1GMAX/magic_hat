import 'dart:convert';

import 'package:magic_hat/model/character_model.dart';
import 'package:http/http.dart';

class ApiService {
  final String api = 'https://hp-api.onrender.com/api';

  Future<List<CharacterModel>> getAllCharacters() async {
    final response = await get(Uri.parse('$api/characters'));
    final List characters = jsonDecode(response.body);
    return characters
        .map((character) => CharacterModel.fromJson(character))
        .toList();
  }
}
