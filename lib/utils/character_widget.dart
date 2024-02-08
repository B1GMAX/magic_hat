import 'package:flutter/material.dart';
import 'package:magic_hat/model/character_model.dart';

class CharacterWidget extends StatelessWidget {
  final bool isListScreen;
  final CharacterModel character;

  const CharacterWidget({
    required this.character,
    this.isListScreen = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return !isListScreen ? Column(
      children: [
        character.image.isNotEmpty
            ? Image.network(
                character.image,
                height: 200,
              )
            : Image.asset(
                'assets/images/anonym.jpg',
                height: 200,
              ),
        Text(
          character.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ) : Row(
      children: [
        character.image.isNotEmpty
            ? Image.network(
          character.image,
          height: 80,
        )
            : Image.asset(
          'assets/images/anonym.jpg',
          height: 80,
        ),
        Text(
          character.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
