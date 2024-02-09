import 'dart:ui';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/model/score_model.dart';
import 'package:magic_hat/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  VoidCallback onHouseTap;

  HomeBloc({required this.onHouseTap});

  final _characterController = BehaviorSubject<CharacterModel>();
  final _scoreModelController = BehaviorSubject<ScoreModel>();

  Stream<CharacterModel> get characterStream => _characterController.stream;

  Stream<ScoreModel> get scoreModelStream => _scoreModelController.stream;

  void onHousePressed({
    required String house,
    required CharacterModel character,
    required Sink<ScoreModel> scoreModelController,
    required ScoreModel scoreModel,
  }) async {
    int totalValue = scoreModel.totalValue;
    int successValue = scoreModel.successValue;
    int failedValue = scoreModel.failedValue;
    totalValue += 1;
    if (house == character.house) {
      successValue += 1;
      character = character.copyWith(isGuessed: true);
    } else {
      failedValue += 1;
      character = character.copyWith(isGuessed: false);
    }

    scoreModelController.add(
      ScoreModel(
        failedValue: failedValue,
        successValue: successValue,
        totalValue: totalValue,
      ),
    );

    await Repository.instance.saveTotalValue(totalValue);
    await Repository.instance.saveSuccessValue(successValue);
    await Repository.instance.saveFailedValue(failedValue);

    await saveCharacterToDb(character);

    onHouseTap();
  }

  Future<void> saveCharacterToDb(CharacterModel character) async {
    List<CharacterModel> passedCharacters =
        await Repository.instance.getPassedCharacters();

    bool found = false;

    for (int i = 0; i < passedCharacters.length; i++) {
      final ch = passedCharacters[i];
      if (ch.id == character.id) {
        passedCharacters[i] = ch.copyWith(
            attempts: ch.attempts! + 1, isGuessed: character.isGuessed);
        found = true;
      }
    }

    if (!found) {
      passedCharacters.add(character.copyWith(attempts: 1));
    }

    await Repository.instance.savePassedCharacters(passedCharacters);
  }

  void dispose() {
    _characterController.close();
    _scoreModelController.close();
  }
}
