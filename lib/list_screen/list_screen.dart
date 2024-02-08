import 'package:flutter/material.dart';
import 'package:magic_hat/details/details_screen.dart';
import 'package:magic_hat/list_screen/list_bloc.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/model/score_model.dart';
import 'package:magic_hat/utils/character_widget.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  final List<CharacterModel> allCharacters;
  final ScoreModel scoreModel;

  const ListScreen({
    required this.allCharacters,
    required this.scoreModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<ListBloc>(
      create: (context) => ListBloc(allCharacters),
      lazy: false,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(),
            StreamBuilder<List<CharacterModel>>(
              stream: context.read<ListBloc>().charactersStream,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Expanded(
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return CharacterWidget(
                                    character: snapshot.data![index],
                                    isListScreen: true,
                                    onCharacterTap: (character) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                              character: character),
                                        ),
                                      );
                                    },
                                  );
                                },
                                childCount: snapshot.data!.length,
                              ),
                            )
                          ],
                        ),
                      )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }
}
