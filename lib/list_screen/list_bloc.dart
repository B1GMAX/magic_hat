import 'package:flutter/cupertino.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:rxdart/rxdart.dart';

class ListBloc {
  final textController = TextEditingController();

  final _characterController = BehaviorSubject<List<CharacterModel>>();

  Stream<List<CharacterModel>> get charactersStream =>
      _characterController.stream;

  ListBloc(
    List<CharacterModel> characters,
  ) {
    textController.addListener(() {
      _characterController.add(characters
          .where((element) => element.name
              .toLowerCase()
              .contains(textController.text.toLowerCase()))
          .toList());
    });
    _characterController.add(characters);
  }

  void dispose() {
    textController.dispose();
    _characterController.close();
  }
}
