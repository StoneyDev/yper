import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yper/features/characters/models/character.dart';
import 'package:yper/features/characters/models/character_repository.dart';
import 'package:yper/features/characters/view_models/character_view_model.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late CharacterViewModel characterViewModel;
  late MockCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    characterViewModel = CharacterViewModel(MockCharacterRepository());
  });

  group('chracters', () {
    final charactersFilter = [
      const Character(
        id: 1,
        name: 'Test 1',
        status: StatusCharacter.alive,
        species: '',
        type: '',
        gender: GenderCharacter.female,
        origin: '',
        image: '',
      ),
      const Character(
        id: 2,
        name: 'Test 2',
        status: StatusCharacter.dead,
        species: '',
        type: '',
        gender: GenderCharacter.genderless,
        origin: '',
        image: '',
      ),
      const Character(
        id: 3,
        name: 'Test 3',
        status: StatusCharacter.unknown,
        species: '',
        type: '',
        gender: GenderCharacter.male,
        origin: '',
        image: '',
      ),
    ];

    test('search characters', () async {
      when(mockCharacterRepository.getAliveCharacters('test')).thenAnswer(
        (_) async => charactersFilter,
      );
      await characterViewModel.filterCharacters('test');
      verify(() => mockCharacterRepository.getAliveCharacters('test')).called(1);
    });
  });
}
