import 'dart:math';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/model/score_model.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final List<CharacterModel> _allCharacters = [];

  HomeBloc({
    required ScoreModel? scoreModel,
    required List<CharacterModel> characters,
  }) {
    _allCharacters.addAll(characters);
    _getRandomCharacter();
  }

  final _characterController = BehaviorSubject<CharacterModel>();
  final _totalController = BehaviorSubject<int>();
  final _successController = BehaviorSubject<int>();
  final _failedController = BehaviorSubject<int>();

  Stream<CharacterModel> get characterStream => _characterController.stream;

  Stream<int> get totalStream => _totalController.stream;

  Stream<int> get successStream => _successController.stream;

  Stream<int> get failedStream => _failedController.stream;

  Future<void> _getRandomCharacter() async {
    print('_allCharacters - ${_allCharacters}');
    int randomIndex = Random().nextInt(_allCharacters.length);

    final randomCharacter = _allCharacters[randomIndex];
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
    await _getRandomCharacter();
  }
}
