import 'package:flutter/material.dart';
import 'package:magic_hat/utils/character_widget.dart';
import 'package:magic_hat/home/home_bloc.dart';
import 'package:magic_hat/home/house_widget.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/model/score_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final ScoreModel scoreModel;
  final List<CharacterModel> characters;
  final Sink<ScoreModel> scoreModelSink;

  const HomeScreen({
    required this.scoreModel,
    required this.characters,
    required this.scoreModelSink,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
      create: (context) => HomeBloc(
        scoreModel: scoreModel,
        characters: characters,
        scoreModelSink: scoreModelSink,
      ),
      lazy: false,
      builder: (context, _) {
        return StreamBuilder<CharacterModel>(
          stream: context.read<HomeBloc>().characterStream,
          builder: (context, characterModelSnapshot) {
            return characterModelSnapshot.hasData
                ? Column(
                    children: [
                      CharacterWidget(character: characterModelSnapshot.data!),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          HouseWidget(
                            houseName: 'Gryffindor',
                            onPressed: (house) {
                              context.read<HomeBloc>().onHousePressed(
                                    house: house,
                                    character: characterModelSnapshot.data!,
                                  );
                            },
                          ),
                          HouseWidget(
                            houseName: 'Slytherin',
                            onPressed: (house) {
                              context.read<HomeBloc>().onHousePressed(
                                    house: house,
                                    character: characterModelSnapshot.data!,
                                  );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          HouseWidget(
                            houseName: 'Ravenclaw',
                            onPressed: (house) {
                              context.read<HomeBloc>().onHousePressed(
                                    house: house,
                                    character: characterModelSnapshot.data!,
                                  );
                            },
                          ),
                          HouseWidget(
                            houseName: 'Hufflepuff',
                            onPressed: (house) {
                              context.read<HomeBloc>().onHousePressed(
                                    house: house,
                                    character: characterModelSnapshot.data!,
                                  );
                            },
                          ),
                        ],
                      ),
                      HouseWidget(
                        houseName: 'Not in a House',
                        isNotInHouse: true,
                        onPressed: (house) {
                          context.read<HomeBloc>().onHousePressed(
                                house: '',
                                character: characterModelSnapshot.data!,
                              );
                        },
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        );
      },
    );
  }
}
