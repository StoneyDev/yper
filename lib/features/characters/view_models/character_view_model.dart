import 'package:flutter/material.dart';
import 'package:yper/features/characters/models/character.dart';
import 'package:yper/features/characters/models/character_repository.dart';

class CharacterViewModel extends ChangeNotifier {
  List<Character> _characters = [];

  bool _isLoading = false;

  // Getter
  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;

  Future<List<Character>> fetchCharacters() async {
    final CharacterRepository characterRepository = CharacterRepository();

    try {
      // Start loading
      _isLoading = !_isLoading;

      notifyListeners();

      // Fetch locations
      _characters = await characterRepository.getAll();

      // Stop loading
      _isLoading = !_isLoading;

      notifyListeners();
    } catch (e) {
      //
    }

    return _characters;
  }
}
