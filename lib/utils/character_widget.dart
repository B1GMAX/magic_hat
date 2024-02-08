import 'package:flutter/material.dart';
import 'package:magic_hat/model/character_model.dart';

class CharacterWidget extends StatelessWidget {
  final bool isListScreen;
  final CharacterModel character;
  final Function(CharacterModel)? onCharacterTap;

  const CharacterWidget({
    required this.character,
    this.isListScreen = false,
    this.onCharacterTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return !isListScreen
        ? Column(
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
          )
        : GestureDetector(
            onTap: () {
              onCharacterTap != null ? onCharacterTap!(character) : null;
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      character.image.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.network(
                                character.image,
                                height: 55,
                              ),
                            )
                          : Image.asset(
                              'assets/images/anonym.jpg',
                              height: 55,
                            ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Attempts: ${character.attempts}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset(
                      'assets/images/${character.isGuessed! ? 'ok' : 'x'}.png')
                ],
              ),
            ),
          );
  }
}
