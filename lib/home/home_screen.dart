import 'package:flutter/material.dart';
import 'package:magic_hat/home/character_widget.dart';
import 'package:magic_hat/home/home_bloc.dart';
import 'package:magic_hat/home/house_widget.dart';
import 'package:magic_hat/home/score_widget.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
      create: (context) => HomeBloc(),
      lazy: false,
      builder: (context, _) {
        return StreamBuilder<CharacterModel>(
          stream: context.read<HomeBloc>().characterStream,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          StreamBuilder<int>(
                              initialData: 0,
                              stream: context.read<HomeBloc>().totalStream,
                              builder: (context, snapshot) {
                                return ScoreWidget(
                                  text: 'Total',
                                  value: snapshot.data!.toString(),
                                );
                              }),
                          StreamBuilder<int>(
                              initialData: 0,
                              stream: context.read<HomeBloc>().successStream,
                              builder: (context, snapshot) {
                                return ScoreWidget(
                                  text: 'Success',
                                  value: snapshot.data!.toString(),
                                );
                              }),
                          StreamBuilder<int>(
                              initialData: 0,
                              stream: context.read<HomeBloc>().failedStream,
                              builder: (context, snapshot) {
                                return ScoreWidget(
                                  text: 'Failed',
                                  value: snapshot.data!.toString(),
                                );
                              }),
                        ],
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
