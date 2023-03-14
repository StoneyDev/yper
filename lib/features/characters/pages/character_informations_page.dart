import 'package:flutter/material.dart';
import 'package:yper/features/characters/models/character.dart';

class CharacterInformationsPage extends StatelessWidget {
  final Character character;

  const CharacterInformationsPage(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(character.image),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Name
            Text(
              character.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Identité'),

                  //
                  const SizedBox(height: 10),

                  Text('Origine: ${character.origin}'),

                  Text('Espèce: ${character.species}'),

                  Text('Statut: ${character.convertStatusInReadableText()}'),

                  Text('Sexe: ${character.convertGenderInReadableText()}'),

                  Text('Type: ${character.type.isNotEmpty ? character.type : 'N/A'}'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
