import 'dart:convert';
import 'dart:math';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/model/score_model.dart';
import 'package:magic_hat/utils/shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final List<CharacterModel> _allCharacters = [];

  HomeBloc({
    required ScoreModel scoreModel,
    required List<CharacterModel> characters,
  }) {
    _allCharacters.addAll(characters);
    print('scoreModel - $scoreModel');

    _scoreModelController.add(scoreModel);

    _getRandomCharacter();
  }

  final _characterController = BehaviorSubject<CharacterModel>();
  final _scoreModelController = BehaviorSubject<ScoreModel>();

  Stream<CharacterModel> get characterStream => _characterController.stream;

  Stream<ScoreModel> get scoreModelStream => _scoreModelController.stream;

  Future<void> _getRandomCharacter() async {
    int randomIndex = Random().nextInt(_allCharacters.length);

    final randomCharacter = _allCharacters[randomIndex];
    _characterController.add(randomCharacter);
  }

  void onHousePressed({
    required String house,
    required CharacterModel character,
  }) async {
    int totalValue = _scoreModelController.hasValue
        ? _scoreModelController.value.totalValue
        : 0;
    int successValue = _scoreModelController.hasValue
        ? _scoreModelController.value.successValue
        : 0;
    int failedValue = _scoreModelController.hasValue
        ? _scoreModelController.value.failedValue
        : 0;
    totalValue = totalValue + 1;
    if (house == character.house) {
      successValue = successValue + 1;
      character = character.copyWith(isGuessed: true);
    } else {
      failedValue = failedValue + 1;
      character = character.copyWith(attempts: character.attempts + 1);
    }
    _scoreModelController.add(
      ScoreModel(
        failedValue: failedValue,
        successValue: successValue,
        totalValue: totalValue,
      ),
    );

    await MagicSharedPreferences.instance.saveTotalValue(totalValue);
    await MagicSharedPreferences.instance.saveSuccessValue(successValue);
    await MagicSharedPreferences.instance.saveFailedValue(failedValue);

    final List<String> passedCharacters =
        await MagicSharedPreferences.instance.getPassedCharacters();

    passedCharacters.add(jsonEncode(character.toJson()));

    await MagicSharedPreferences.instance
        .savePassedCharacters(passedCharacters);

    await _getRandomCharacter();
  }
}
