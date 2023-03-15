import 'package:yper/features/characters/models/character.dart';

class ResponseCharacter {
  final int totalPage;
  final List<Character> characters;

  const ResponseCharacter({required this.totalPage, required this.characters});

  factory ResponseCharacter.fromJson(Map<String, dynamic> json) {
    return ResponseCharacter(
      totalPage: json['info']['pages'],
      characters: (json['results'] as List).map((e) => Character.fromJson(e)).toList(),
    );
  }
}
