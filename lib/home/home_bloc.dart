import 'dart:math';

import 'package:magic_hat/api_service/api_service.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final ApiService _apiService = ApiService();

  HomeBloc() {
    _getRandoCharacter();
  }

  final _characterController = BehaviorSubject<CharacterModel>();
  final _totalController = BehaviorSubject<int>();
  final _successController = BehaviorSubject<int>();
  final _failedController = BehaviorSubject<int>();

  Stream<CharacterModel> get characterStream => _characterController.stream;

  Stream<int> get totalStream => _totalController.stream;

  Stream<int> get successStream => _successController.stream;

  Stream<int> get failedStream => _failedController.stream;

  Future<void> _getRandoCharacter() async {
    final characters = await _apiService.getAllCharacters();
    int randomIndex = Random().nextInt(characters.length);

    final randomCharacter = characters[randomIndex];
    _characterController.add(randomCharacter);
  }

  void onHousePressed(String house, String characterHouse) async {
    int totalValue = _totalController.hasValue ? _totalController.value : 0;
    _totalController.add(totalValue = totalValue + 1);
    if (house == characterHouse) {
      int successValue =
          _successController.hasValue ? _successController.value : 0;
      _successController.add(successValue = successValue + 1);
    } else {
      int failedValue =
          _failedController.hasValue ? _failedController.value : 0;
      _failedController.add(failedValue = failedValue + 1);
    }
    await _getRandoCharacter();
  }
}
