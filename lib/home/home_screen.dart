import 'package:flutter/material.dart';
import 'package:magic_hat/home/home_bloc.dart';
import 'package:magic_hat/home/house_widget.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/model/score_model.dart';
import 'package:magic_hat/widgets/character_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final ScoreModel scoreModel;
  final CharacterModel? character;
  final VoidCallback onHousePressedOrRefresh;
  final Sink<ScoreModel> scoreModelController;

  const HomeScreen({
    required this.scoreModel,
    required this.character,
    required this.scoreModelController,
    required this.onHousePressedOrRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
      create: (context) => HomeBloc(onHouseTap: onHousePressedOrRefresh),
      lazy: false,
      dispose: (context, bloc) => bloc.dispose(),
      builder: (context, _) {
        return character != null
            ? RefreshIndicator(
                onRefresh: () async {
                  onHousePressedOrRefresh();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      CharacterWidget(character: character!),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          HouseWidget(
                            houseName: 'Gryffindor',
                            onPressed: (house) {
                              context.read<HomeBloc>().onHousePressed(
                                    house: house,
                                    character: character!,
                                    scoreModelController: scoreModelController,
                                    scoreModel: scoreModel,
                                  );
                            },
                          ),
                          HouseWidget(
                            houseName: 'Slytherin',
                            onPressed: (house) {
                              context.read<HomeBloc>().onHousePressed(
                                    house: house,
                                    character: character!,
                                    scoreModelController: scoreModelController,
                                    scoreModel: scoreModel,
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
                                    character: character!,
                                    scoreModelController: scoreModelController,
                                    scoreModel: scoreModel,
                                  );
                            },
                          ),
                          HouseWidget(
                            houseName: 'Hufflepuff',
                            onPressed: (house) {
                              context.read<HomeBloc>().onHousePressed(
                                    house: house,
                                    character: character!,
                                    scoreModelController: scoreModelController,
                                    scoreModel: scoreModel,
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
                                character: character!,
                                scoreModelController: scoreModelController,
                                scoreModel: scoreModel,
                              );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: Text(
                  'No any new Character',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
      },
    );
  }
}
