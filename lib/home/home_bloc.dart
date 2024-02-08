import 'dart:convert';
import 'dart:math';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/model/score_model.dart';
import 'package:magic_hat/utils/shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final List<CharacterModel> _allCharacters = [];

  final ScoreModel? scoreModel;
  final Sink<ScoreModel> scoreModelSink;

  HomeBloc({
    this.scoreModel,
    required List<CharacterModel> characters,
    required this.scoreModelSink,
  }) {
    _allCharacters.addAll(characters);

    // _scoreModelController.add(scoreModel);

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
    int totalValue = scoreModel != null ? scoreModel!.totalValue : 0;
    int successValue = scoreModel != null ? scoreModel!.successValue : 0;
    int failedValue = scoreModel != null ? scoreModel!.failedValue : 0;
    totalValue = totalValue + 1;
    if (house == character.house) {
      successValue = successValue + 1;
      character = character.copyWith(isGuessed: true);
    } else {
      failedValue = failedValue + 1;
      character = character.copyWith(isGuessed: false);
    }
    int attempts = character.attempts ?? 0;

    attempts = attempts + 1;

    if (character.isGuessed != true) {
      character = character.copyWith(attempts: attempts);
    } else {
      character = character.copyWith(
          attempts: character.attempts != null ? attempts : 1);
    }

    scoreModelSink.add(
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
        .savePassedCharacters(passedCharacters.toSet().toList());

    await _getRandomCharacter();
  }
}
