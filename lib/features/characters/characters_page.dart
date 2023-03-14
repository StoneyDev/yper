import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yper/features/characters/pages/character_informations_page.dart';
import 'package:yper/features/characters/view_models/character_view_model.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CharacterViewModel>(
      create: (_) => CharacterViewModel()..fetchCharacters(),
      child: Consumer<CharacterViewModel>(
        builder: (context, value, child) {
          // Loading widget
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Displaying data
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: value.characters.length,
            itemBuilder: (context, index) => Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Theme.of(context).primaryColor.withAlpha(30),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => CharacterInformationsPage(value.characters[index]),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(value.characters[index].image),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value.characters[index].name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(value.characters[index].origin),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
