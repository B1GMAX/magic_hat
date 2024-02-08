import 'package:flutter/material.dart';
import 'package:magic_hat/model/character_model.dart';

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
                  icon: Icon(Icons.arrow_back),
                ),
                Text('Back'),
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
      body: Row(
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
          const SizedBox(width: 10),
          character.isGuessed!
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'House:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          character.house,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    if (character.dateOfBirth != null)
                      const SizedBox(height: 10),
                    if (character.dateOfBirth != null)
                      Row(
                        children: [
                          const Text(
                            'Date of birth:',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            character.house,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Actor:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          character.actor,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Species:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          character.species,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                )
              : Image.asset('assets/images/access_denied.png'),
        ],
      ),
    );
  }
}
