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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ScoreWidget(
                            text: 'Total',
                            value: '4',
                          ),
                          ScoreWidget(
                            text: 'Success',
                            value: '3',
                          ),
                          ScoreWidget(
                            text: 'Failed',
                            value: '1',
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CharacterWidget(character: snapshot.data!),
                      const SizedBox(height: 15),
                      const Row(
                        children: [
                          HouseWidget(houseName: 'Gryffindor'),
                          HouseWidget(houseName: 'Slytherin'),
                        ],
                      ),
                      const Row(
                        children: [
                          HouseWidget(houseName: 'Ravenclaw'),
                          HouseWidget(houseName: 'Hufflepuff'),
                        ],
                      ),
                      const HouseWidget(houseName: 'Not in a House', isNotInHouse: true,),
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
