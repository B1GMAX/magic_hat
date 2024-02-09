import 'package:flutter/cupertino.dart';
import 'package:magic_hat/model/character_model.dart';

class ListCharacterWidget extends StatelessWidget {
  final CharacterModel character;
  final Function(CharacterModel)? onCharacterTap;
  final Function(CharacterModel)? onCharacterReload;

  const ListCharacterWidget({
    required this.character,
    required this.onCharacterReload,
    required this.onCharacterTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (onCharacterTap != null) {
                onCharacterTap!(character);
              }
            },
            child: Row(
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
          ),
          Row(
            children: [
              if (!character.isGuessed!)
                GestureDetector(
                  onTap: () {
                    if (onCharacterReload != null) {
                      onCharacterReload!(character);
                    }
                  },
                  child: Image.asset('assets/images/reset.png'),
                ),
              if (!character.isGuessed!) const SizedBox(width: 8),
              Image.asset(
                'assets/images/${character.isGuessed! ? 'ok' : 'x'}.png',
              ),
            ],
          )
        ],
      ),
    );
  }
}
