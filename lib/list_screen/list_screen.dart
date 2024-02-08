import 'package:flutter/material.dart';
import 'package:magic_hat/list_screen/list_bloc.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/utils/character_widget.dart';
import 'package:magic_hat/utils/scores.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  final List<CharacterModel> allCharacters;

  const ListScreen({
    required this.allCharacters,
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
            Scores(
              totalText: 'Total',
              totalValue: 6.toString(),
              successText: 'Success',
              successValue: 6.toString(),
              failedText: 'Failed',
              failedValue: 6.toString(),
            ),
            TextField(),
            StreamBuilder<List<CharacterModel>>(
              stream: context.read<ListBloc>().charactersStream,
              builder: (context, snapshot) {
                print('snapshot.data - ${snapshot.data}');
                return snapshot.hasData
                    ? Expanded(
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  print(
                                      'snapshot.data![index - ${snapshot.data![index]}');
                                  return CharacterWidget(
                                    character: snapshot.data![index],
                                    isListScreen: true,
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
          ],
        );
      },
    );
  }
}
