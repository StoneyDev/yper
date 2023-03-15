import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:yper/data/helpers/http_helper.dart';
import 'package:yper/data/models/response_character.dart';
import 'package:yper/features/characters/models/character.dart';

class CharacterRepository {
  /// Get all characters
  Future<ResponseCharacter> getAll(int page) async {
    final Uri url = Uri.parse('${HttpClient.charactersEndpoint}/?page=$page');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return ResponseCharacter.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to fetch characters');
    }
  }

  /// Get character informations by id
  Future<Character> getInfos(int id) async {
    final Uri url = Uri.parse('${HttpClient.charactersEndpoint}/$id');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return Character.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to fetch character: $id');
    }
  }

  /// Get alive characters by name
  Future<List<Character>> getAliveCharacters(String value) async {
    final Uri url = Uri.parse('${HttpClient.charactersEndpoint}/?name=$value&status=alive');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final characters = List<Map<String, dynamic>>.from(jsonDecode(res.body)['results']);

      return characters.map((e) => Character.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
