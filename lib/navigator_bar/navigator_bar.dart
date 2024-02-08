import 'package:flutter/material.dart';
import 'package:magic_hat/home/home_screen.dart';
import 'package:magic_hat/list_screen/list_screen.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/model/score_model.dart';
import 'package:magic_hat/navigator_bar/navigator_bar_bloc.dart';
import 'package:magic_hat/utils/scores.dart';
import 'package:provider/provider.dart';

import 'navigator_bar_widget.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  @override
  Widget build(BuildContext context) {
    return Provider<NavigatorBarBloc>(
      create: (context) => NavigatorBarBloc(),
      lazy: false,
      builder: (context, _) {
        return StreamBuilder<int>(
          initialData: 0,
          stream: context.read<NavigatorBarBloc>().indexPageStream,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size(double.infinity, 50),
                child: Container(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: AppBar(
                    centerTitle: true,
                    title: Text(
                      snapshot.data! == 0 ? 'Home Screen' : 'List Screen',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          context.read<NavigatorBarBloc>().reset();
                        },
                        child: const Text(
                          'Reset',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: NavigatorBarWidget(
                onPageChange: (index) {
                  context.read<NavigatorBarBloc>().changeIndexPage(index);
                },
                homeColor: snapshot.data! == 0 ? Colors.black : Colors.grey,
                listColor: snapshot.data! == 1 ? Colors.black : Colors.grey,
              ),
              body: StreamBuilder<List<CharacterModel>>(
                stream: context.read<NavigatorBarBloc>().allCharactersStream,
                builder: (context, allCharactersSnapshot) {
                  return StreamBuilder<ScoreModel>(
                    stream: context.read<NavigatorBarBloc>().scoreModelStream,
                    builder: (context, scoreSnapshot) {
                      return scoreSnapshot.hasData &&
                              allCharactersSnapshot.hasData
                          ? Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(
                                children: [
                                  Scores(
                                    totalText: 'Total',
                                    totalValue: scoreSnapshot.data!.totalValue
                                        .toString(),
                                    successText: 'Success',
                                    successValue: scoreSnapshot
                                        .data!.successValue
                                        .toString(),
                                    failedText: 'Failed',
                                    failedValue: scoreSnapshot.data!.failedValue
                                        .toString(),
                                  ),
                                  Expanded(
                                    child: PageView(
                                      controller: context
                                          .read<NavigatorBarBloc>()
                                          .pagViewController,
                                      onPageChanged: (index) {
                                        context
                                            .read<NavigatorBarBloc>()
                                            .changeIndexPage(index);
                                      },
                                      children: [
                                        HomeScreen(
                                          scoreModel: scoreSnapshot.data!,
                                          characters:
                                              allCharactersSnapshot.data!,
                                          scoreModelSink: context
                                              .read<NavigatorBarBloc>()
                                              .scoreModelSink,
                                        ),
                                        ListScreen(
                                          allCharacters:
                                              allCharactersSnapshot.data!,
                                          scoreModel: scoreSnapshot.data!,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
