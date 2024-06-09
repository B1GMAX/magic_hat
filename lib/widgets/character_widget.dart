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
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        character.image.isNotEmpty
            ? Image.network(
                character.image,
                height: height * 0.283,
              )
            : Image.asset(
                'assets/images/anonym.jpg',
                height: height * 0.283,
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
