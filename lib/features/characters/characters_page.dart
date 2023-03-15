import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yper/features/characters/models/character.dart';
import 'package:yper/features/characters/pages/character_informations_page.dart';
import 'package:yper/features/characters/view_models/character_view_model.dart';
import 'package:yper/features/characters/widgets/search_characters.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CharacterViewModel>(
      create: (_) => CharacterViewModel()..fetchCharacters(),
      child: Column(
        children: [
          // Search field
          const Padding(
            padding: EdgeInsets.all(16),
            child: SearchCharacters(),
          ),

          Consumer<CharacterViewModel>(
            builder: (context, value, child) {
              if (value.isSearchingMode && value.filterCharacter.isEmpty) {
                return const Text('Aucun résultat');
              }

              if (!value.isLoading) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: value.isSearchingMode ? value.filterCharacter.length : value.characters.length,
                    itemBuilder: (context, index) {
                      final Character character =
                          value.isSearchingMode ? value.filterCharacter[index] : value.characters[index];

                      return Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Theme.of(context).primaryColor.withAlpha(30),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => CharacterInformationsPage(character),
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
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(character.image),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: character.status == StatusCharacter.alive
                                              ? Colors.green
                                              : character.status == StatusCharacter.dead
                                                  ? Colors.red
                                                  : Colors.black,
                                          maxRadius: 6,
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            character.name,
                                            style: Theme.of(context).textTheme.titleLarge,
                                          ),
                                          Text(character.origin),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
