import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:yper/features/characters/view_models/character_view_model.dart';
import 'package:yper/features/characters/widgets/search_characters.dart';

void main() {
  testWidgets('Render', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: ChangeNotifierProvider<CharacterViewModel>(
            create: (context) => CharacterViewModel(),
            child: const SearchCharacters(),
          ),
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Typing text', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: ChangeNotifierProvider<CharacterViewModel>(
            create: (context) => CharacterViewModel(),
            child: const SearchCharacters(),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Rick');

    // For fake clock
    // https://github.com/flutter/flutter/issues/11181#issuecomment-568737491
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });

  testWidgets('Clear button is displayed correctly with no data', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: ChangeNotifierProvider<CharacterViewModel>(
            create: (context) => CharacterViewModel(),
            child: const SearchCharacters(),
          ),
        ),
      ),
    );

    expect(find.byType(IconButton), findsNothing);
  });

  testWidgets('Clear button is displayed correctly with data', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: ChangeNotifierProvider<CharacterViewModel>(
            create: (context) => CharacterViewModel(),
            child: const SearchCharacters(),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Rick');

    // For fake clock
    // https://github.com/flutter/flutter/issues/11181#issuecomment-568737491
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(IconButton), findsOneWidget);
  });
}
