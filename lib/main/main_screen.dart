import 'package:flutter/material.dart';
import 'package:magic_hat/home/home_screen.dart';
import 'package:magic_hat/list_screen/list_screen.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/model/score_model.dart';
import 'package:magic_hat/widgets/main_screen_appbar.dart';
import 'package:magic_hat/widgets/scores_header.dart';
import 'package:provider/provider.dart';

import 'main_bloc.dart';
import 'navigator_bar_element.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Provider<MainBloc>(
      create: (context) => MainBloc(),
      lazy: false,
      builder: (context, _) {
        context.read<MainBloc>().loadAllCharacters();
        return StreamBuilder<int>(
          initialData: 0,
          stream: context.read<MainBloc>().indexPageStream,
          builder: (context, snapshot) {
            return SafeArea(
              child: Scaffold(
                bottomNavigationBar: NavigatorBarWidget(
                  onPageChange: context.read<MainBloc>().changeIndexPage,
                  homeColor: snapshot.data! == 0 ? Colors.black : Colors.grey,
                  listColor: snapshot.data! == 1 ? Colors.black : Colors.grey,
                ),
                body: StreamBuilder<CharacterModel?>(
                  stream: context.read<MainBloc>().characterStream,
                  builder: (context, allCharactersSnapshot) {
                    return StreamBuilder<ScoreModel>(
                      stream: context.read<MainBloc>().scoreModelStream,
                      builder: (context, scoreSnapshot) {
                        return scoreSnapshot.hasData
                            ? Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Column(
                                  children: [
                                    MainScreenAppBar(
                                      text: snapshot.data! == 0
                                          ? 'Home Screen'
                                          : 'List Screen',
                                      onTap: context.read<MainBloc>().reset,
                                    ),
                                    const SizedBox(height: 10),
                                    ScoresHeader(
                                      totalText: 'Total',
                                      totalValue: scoreSnapshot.data!.totalValue
                                          .toString(),
                                      successText: 'Success',
                                      successValue: scoreSnapshot
                                          .data!.successValue
                                          .toString(),
                                      failedText: 'Failed',
                                      failedValue: scoreSnapshot
                                          .data!.failedValue
                                          .toString(),
                                    ),
                                    Expanded(
                                      child: PageView(
                                        scrollDirection: Axis.horizontal,
                                        controller: context
                                            .read<MainBloc>()
                                            .pagViewController,
                                        onPageChanged: context
                                            .read<MainBloc>()
                                            .changeIndexPage,
                                        children: [
                                          HomeScreen(
                                            scoreModel: scoreSnapshot.data!,
                                            character:
                                                allCharactersSnapshot.data,
                                            scoreModelController: context
                                                .read<MainBloc>()
                                                .scoreModelSink,
                                            onHousePressedOrRefresh: context
                                                .read<MainBloc>()
                                                .loadAllCharacters,
                                          ),
                                          StreamBuilder<List<CharacterModel>>(
                                              stream: context
                                                  .read<MainBloc>()
                                                  .passedCharactersStream,
                                              builder: (context,
                                                  passedCharacterSnapshot) {
                                                return passedCharacterSnapshot
                                                        .hasData
                                                    ? ListScreen(
                                                        allPassedCharacters:
                                                            passedCharacterSnapshot
                                                                .data!,
                                                        onCharacterReload: context
                                                            .read<MainBloc>()
                                                            .onCharacterReload,
                                                      )
                                                    : const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const Center(child: CircularProgressIndicator());
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
