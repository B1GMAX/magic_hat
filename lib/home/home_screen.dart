import 'package:flutter/material.dart';
import 'package:magic_hat/home/character_widget.dart';
import 'package:magic_hat/home/home_bloc.dart';
import 'package:magic_hat/home/house_widget.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/model/score_model.dart';
import 'package:magic_hat/utils/scores.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final ScoreModel? scoreModel;
  final List<CharacterModel> characters;

  const HomeScreen({
    required this.scoreModel,
    required this.characters,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
      create: (context) => HomeBloc(
        scoreModel: scoreModel,
        characters: characters,
      ),
      lazy: false,
      builder: (context, _) {
        return StreamBuilder<CharacterModel>(
          stream: context.read<HomeBloc>().characterStream,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Column(
                    children: [
                      Scores(
                        totalText: 'Total',
                        totalValue: snapshot.data!.toString(),
                        successText: 'Success',
                        successValue: snapshot.data!.toString(),
                        failedText: 'Failed',
                        failedValue: snapshot.data!.toString(),
                      ),
                      const SizedBox(height: 15),
                      CharacterWidget(character: snapshot.data!),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          HouseWidget(
                            houseName: 'Gryffindor',
                            onPressed: (house) {
                              context.read<HomeBloc>().onHousePressed(
                                    house,
                                    snapshot.data!.house,
                                  );
                            },
                          ),
                          HouseWidget(
                            houseName: 'Slytherin',
                            onPressed: (house) {
                              context.read<HomeBloc>().onHousePressed(
                                    house,
                                    snapshot.data!.house,
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
                                    house,
                                    snapshot.data!.house,
                                  );
                            },
                          ),
                          HouseWidget(
                            houseName: 'Hufflepuff',
                            onPressed: (house) {
                              context.read<HomeBloc>().onHousePressed(
                                    house,
                                    snapshot.data!.house,
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
                                '',
                                snapshot.data!.house,
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
