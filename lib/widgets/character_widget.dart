import 'package:flutter/material.dart';
import 'package:magic_hat/model/character_model.dart';

class CharacterWidget extends StatelessWidget {
  final CharacterModel character;

  const CharacterWidget({
    required this.character,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
