class Character {
  final int id;
  final String name;
  final StatusCharacter status;
  final String species;
  final String type;
  final GenderCharacter gender;
  final String origin;
  final String image;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: getStatus(json['status']),
      species: json['species'],
      type: json['type'],
      gender: getGender(json['gender']),
      origin: json['origin']['name'],
      image: json['image'],
    );
  }

  static StatusCharacter getStatus(String value) {
    switch (value) {
      case 'Alive':
        return StatusCharacter.alive;
      case 'Dead':
        return StatusCharacter.dead;
      default:
        return StatusCharacter.unknown;
    }
  }

  static GenderCharacter getGender(String value) {
    switch (value) {
      case 'Female':
        return GenderCharacter.female;
      case 'Male':
        return GenderCharacter.male;
      case 'Genderless':
        return GenderCharacter.genderless;
      default:
        return GenderCharacter.unknown;
    }
  }
}

enum StatusCharacter { alive, dead, unknown }

enum GenderCharacter { female, male, genderless, unknown }
