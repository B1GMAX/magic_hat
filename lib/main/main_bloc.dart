import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:magic_hat/api_service/api_service.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/model/score_model.dart';
import 'package:magic_hat/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {
  final ApiService _apiService = ApiService();
  final pagViewController = PageController();

  final _indexPageController = BehaviorSubject<int>();
  final _scoreModelController = BehaviorSubject<ScoreModel>();
  final _charactersController = BehaviorSubject<CharacterModel?>();
  final _passedCharacterController = BehaviorSubject<List<CharacterModel>>();

  Stream<List<CharacterModel>> get passedCharactersStream =>
      _passedCharacterController.stream;

  Stream<int> get indexPageStream => _indexPageController.stream;

  Stream<ScoreModel> get scoreModelStream => _scoreModelController.stream;

  Stream<CharacterModel?> get characterStream => _charactersController.stream;

  Sink<ScoreModel> get scoreModelSink => _scoreModelController.sink;

  MainBloc() {
    _getSavedData();
  }

  void changeIndexPage(int index) async {
    pagViewController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    _indexPageController.add(index);
  }

  void onCharacterReload(CharacterModel? character) {
    pagViewController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    _charactersController.add(character);
    _indexPageController.add(0);
  }

  Future<void> loadAllCharacters() async {
    final List<CharacterModel> passedCharacters =
        await Repository.instance.getPassedCharacters();

    final allCharacters = await _apiService.getAllCharacters();

    for (final passedCharacter in passedCharacters) {
      allCharacters.removeWhere((element) =>
          element.id == passedCharacter.id &&
          passedCharacter.isGuessed == true);
    }
    await _getPassedCharacters();

    _getRandomCharacter(allCharacters);
  }

  void _getRandomCharacter(List<CharacterModel> allCharacters) {
    if (allCharacters.isEmpty) {
      _charactersController.add(null);
    } else {
      int randomIndex = Random().nextInt(allCharacters.length);
      final randomCharacter = allCharacters[randomIndex];
      _charactersController.add(randomCharacter);
    }
  }

  Future<void> _getPassedCharacters() async {
    final passedCharacters = await Repository.instance.getPassedCharacters();

    _passedCharacterController.add(passedCharacters);
  }

  Future<void> _getSavedData() async {
    final totalValue = await Repository.instance.getTotalValue();
    final successValue = await Repository.instance.getSuccessValue();
    final failedValue = await Repository.instance.getFailedValue();
    _scoreModelController.add(ScoreModel(
      failedValue: failedValue,
      successValue: successValue,
      totalValue: totalValue,
    ));
  }

  void reset() async {
    await Repository.instance.saveTotalValue(0);
    await Repository.instance.saveSuccessValue(0);
    await Repository.instance.saveFailedValue(0);
    await Repository.instance.savePassedCharacters([]);
    await _getSavedData();
    await _getPassedCharacters();
    pagViewController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    _indexPageController.add(0);
  }

  void dispose() {
    pagViewController.dispose();
    _scoreModelController.close();
    _passedCharacterController.close();
    _charactersController.close();
    _indexPageController.close();
    scoreModelSink.close();
  }
}
