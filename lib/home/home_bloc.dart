import 'dart:math';

import 'package:magic_hat/api_service/api_service.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final ApiService _apiService = ApiService();

  HomeBloc() {
    getRandoCharacter();
  }

  final _characterController = BehaviorSubject<CharacterModel>();

  Stream<CharacterModel> get characterStream => _characterController.stream;

  void getRandoCharacter() async {
    final characters = await _apiService.getAllCharacters();
    int randomIndex = Random().nextInt(characters.length);

    final randomCharacter = characters[randomIndex];
    _characterController.add(randomCharacter);
  }
}
