import 'package:flutter/material.dart';
import 'package:magic_hat/details/details_screen.dart';
import 'package:magic_hat/list_screen/list_bloc.dart';
import 'package:magic_hat/model/character_model.dart';
import 'package:magic_hat/widgets/list_character_widget.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  final List<CharacterModel> allPassedCharacters;
  final Function(CharacterModel?) onCharacterReload;

  const ListScreen({
    required this.allPassedCharacters,
    required this.onCharacterReload,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<ListBloc>(
      create: (context) => ListBloc(allPassedCharacters),
      dispose: (context, bloc) => bloc.dispose(),
      lazy: false,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: context.read<ListBloc>().textController,
                decoration: const InputDecoration(
                  hintText: 'Enter text',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 3),
                  ),
                  suffixIcon: Icon(Icons.search, color: Colors.black),
                ),
              ),
            ),
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
                                  return ListCharacterWidget(
                                    character: snapshot.data![index],
                                    onCharacterReload: onCharacterReload,
                                    onCharacterTap: (character) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                            character: character,
                                          ),
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
