import 'package:flutter/material.dart';
import 'package:magic_hat/model/character_model.dart';

import 'character_description.dart';

class DetailsScreen extends StatelessWidget {
  final CharacterModel character;

  const DetailsScreen({
    required this.character,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black),
            ),
          ),
          child: AppBar(
            centerTitle: true,
            leadingWidth: 100,
            leading: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Text('Back'),
              ],
            ),
            title: Text(
              character.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            character.image.isNotEmpty
                ? Image.network(
                    character.image,
                    height: 200,
                  )
                : Image.asset(
                    'assets/images/anonym.jpg',
                    height: 170,
                  ),
            const SizedBox(width: 10),
            character.isGuessed!
                ? Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CharacterDescription(
                          description: character.house.isNotEmpty
                              ? character.house
                              : 'Not in a House ',
                          descriptionName: 'House:',
                        ),
                        if (character.dateOfBirth != null)
                          const SizedBox(height: 10),
                        if (character.dateOfBirth != null)
                          CharacterDescription(
                            description: character.dateOfBirth!,
                            descriptionName: 'Date of birth:',
                          ),
                        if (character.actor.isNotEmpty)
                          const SizedBox(height: 10),
                        if (character.actor.isNotEmpty)
                          CharacterDescription(
                            description: character.actor,
                            descriptionName: 'Actor:',
                          ),
                        const SizedBox(height: 10),
                        CharacterDescription(
                          description: character.species,
                          descriptionName: 'Species:',
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  )
                : Flexible(
                    child: Image.asset('assets/images/access_denied.png'),
                  ),
          ],
        ),
      ),
    );
  }
}
