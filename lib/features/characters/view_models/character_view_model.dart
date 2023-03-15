import 'package:flutter/material.dart';
import 'package:yper/data/models/response_character.dart';
import 'package:yper/features/characters/models/character.dart';
import 'package:yper/features/characters/models/character_repository.dart';

class CharacterViewModel extends ChangeNotifier {
  final CharacterRepository characterRepository = CharacterRepository();
  final TextEditingController searchController = TextEditingController();

  List<Character> _characters = [];
  List<Character> _filterCharacters = [];

  bool _isLoading = false;
  bool _isSearchingMode = false;
  int _totalPage = 0;
  int _currentPage = 0;

  // Getter
  List<Character> get characters => _characters;
  List<Character> get filterCharacter => _filterCharacters;
  bool get isLoading => _isLoading;
  bool get isSearchingMode => _isSearchingMode;
  int get totalPage => _totalPage;
  int get currentPage => _currentPage;

  Future<List<Character>> fetchCharacters() async {
    try {
      // Start loading
      _isLoading = !_isLoading;

      print(_currentPage);

      notifyListeners();

      // Fetch locations
      final ResponseCharacter res = await characterRepository.getAll(_currentPage);

      _totalPage = res.totalPage;
      _characters = [..._characters, ...res.characters];
      _currentPage += 1;

      // Stop loading
      _isLoading = !_isLoading;

      notifyListeners();
    } catch (e) {
      //
    }

    return _characters;
  }

  Future<void> filterCharacters(String value) async {
    // Start loading
    _isLoading = true;

    _isSearchingMode = true;

    notifyListeners();

    // Fetch data
    final List<Character> res = await characterRepository.getAliveCharacters(value);

    // Take the first 5 living characters
    _filterCharacters = res.take(5).toList();

    // Stop loading
    _isLoading = false;

    notifyListeners();
  }

  void searchClear() {
    _isSearchingMode = false;

    notifyListeners();
  }
}
