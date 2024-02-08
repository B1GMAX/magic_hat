import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:magic_hat/api_service/api_service.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/model/score_model.dart';
import 'package:magic_hat/utils/shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class NavigatorBarBloc {
  final ApiService _apiService = ApiService();
  final pagViewController = PageController();

  final _indexPageController = BehaviorSubject<int>();
  final _scoreModelController = BehaviorSubject<ScoreModel>();
  final _allCharactersSController = BehaviorSubject<List<CharacterModel>>();

  Stream<int> get indexPageStream => _indexPageController.stream;

  Stream<ScoreModel> get scoreModelStream => _scoreModelController.stream;

  Stream<List<CharacterModel>> get allCharactersStream =>
      _allCharactersSController.stream;

  NavigatorBarBloc() {
    _getSavedData();
    _getAllCharacters();
  }

  void changeIndexPage(int index) {
    pagViewController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);

    _indexPageController.add(index);
  }

  Future<void> _getAllCharacters() async {
    final List<String> passedCharacters =
        await MagicSharedPreferences.instance.getPassedCharacters();

    final allCharacters = await _apiService.getAllCharacters();

    for (final passedCharacter in passedCharacters) {
      allCharacters.removeWhere((element) =>
          element.id ==
          CharacterModel.fromJson(jsonDecode(passedCharacter)).id);
    }

    _allCharactersSController.add(allCharacters);
  }

  Future<void> _getSavedData() async {
    final totalValue = await MagicSharedPreferences.instance.getTotalValue();
    final successValue =
        await MagicSharedPreferences.instance.getSuccessValue();
    final failedValue = await MagicSharedPreferences.instance.getFailedValue();
    _scoreModelController.add(ScoreModel(
      failedValue: failedValue,
      successValue: successValue,
      totalValue: totalValue,
    ));
  }
}
