import 'dart:convert';

import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/utils/shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class ListBloc {
  ListBloc(
    List<CharacterModel> allCharacters,
  ) {
    _getPassedCharacters(allCharacters);
  }

  final _characterController = BehaviorSubject<List<CharacterModel>>();

  Stream<List<CharacterModel>> get charactersStream =>
      _characterController.stream;

  Future<void> _getPassedCharacters(List<CharacterModel> allCharacters) async {
    final List<CharacterModel> characters = [];
    final passedCharacters =
        await MagicSharedPreferences.instance.getPassedCharacters();

    for (final passCharacterId in passedCharacters) {
      characters.add(CharacterModel.fromJson(jsonDecode(passCharacterId)));
    }

    _characterController.add(characters);
  }
}
