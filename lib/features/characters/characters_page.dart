import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yper/features/characters/models/character.dart';
import 'package:yper/features/characters/models/character_repository.dart';
import 'package:yper/features/characters/pages/character_informations_page.dart';
import 'package:yper/features/characters/view_models/character_view_model.dart';
import 'package:yper/features/characters/widgets/search_characters.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CharacterViewModel>(
      create: (_) => CharacterViewModel(CharacterRepository())..fetchCharacters(),
      child: Consumer<CharacterViewModel>(
        builder: (context, value, child) {
          return Column(
            children: [
              // Search field
              const Padding(
                padding: EdgeInsets.all(16),
                child: SearchCharacters(),
              ),

              if (value.isSearchingMode && value.filterCharacter.isEmpty) const Text('Aucun résultat'),

              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification? notification) {
                    final ScrollMetrics? position = notification?.metrics;

                    if (value.currentPage <= value.totalPage && !value.isSearchingMode) {
                      if ((position?.pixels ?? 0) >= ((position?.maxScrollExtent ?? 0) - 120) && !value.isLoading) {
                        // Fetch data
                        value.fetchCharacters();

                        return true;
                      }
                    }

                    return false;
                  },
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
                ),
              ),

              if (value.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}
