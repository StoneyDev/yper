import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yper/features/characters/view_models/character_view_model.dart';

class SearchCharacters extends StatefulWidget {
  const SearchCharacters({super.key});

  @override
  State<SearchCharacters> createState() => _SearchCharactersState();
}

class _SearchCharactersState extends State<SearchCharacters> {
  final TextEditingController searchController = TextEditingController();
  Timer? searchOnStoppedTyping;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CharacterViewModel searchProvider = Provider.of<CharacterViewModel>(context, listen: false);
    final characterWatch = context.watch<CharacterViewModel>();

    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Rechercher un personnage vivant',
        suffixIcon: characterWatch.isSearchingMode
            ? IconButton(
                onPressed: () {
                  // Clear state
                  searchProvider.searchClear();

                  // Clear field
                  searchController.clear();
                },
                icon: const Icon(Icons.cancel_rounded),
              )
            : null,
      ),
      onChanged: (value) {
        if (searchOnStoppedTyping != null) {
          searchOnStoppedTyping?.cancel();
        }

        // Debounce
        searchOnStoppedTyping = Timer(
          const Duration(seconds: 3),
          () => searchProvider.filterCharacters(value),
        );
      },
    );
  }
}
