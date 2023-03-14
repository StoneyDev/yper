import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:yper/data/helpers/http_helper.dart';
import 'package:yper/features/characters/models/character.dart';

class CharacterRepository {
  /// Get all characters
  Future<List<Character>> getAll() async {
    final Uri url = Uri.parse(HttpClient.charactersEndpoint);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final characters = List<Map<String, dynamic>>.from(jsonDecode(res.body)['results']);

      return characters.map((e) => Character.fromJson(e)).toList();
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
}
