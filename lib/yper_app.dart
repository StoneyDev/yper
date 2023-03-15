import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yper/features/characters/characters_page.dart';
import 'package:yper/features/episodes/episodes_page.dart';
import 'package:yper/features/locations/locations_page.dart';
import 'package:yper/features/navigation_bar/view_models/navigation_view_model.dart';

class YperApp extends StatelessWidget {
  const YperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yper',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<NavigationViewModel>(
        create: (_) => NavigationViewModel(),
        child: Consumer<NavigationViewModel>(
          builder: (context, value, child) => Scaffold(
            appBar: AppBar(title: const Text('Rick et Morty')),
            body: <Widget>[
              const CharactersPage(),
              const LocationsPage(),
              const EpisodesPage(),
            ][value.currentPageIndex],
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: value.onPageChanged,
              selectedIndex: value.currentPageIndex,
              destinations: const <Widget>[
                // Redirects to characters view
                NavigationDestination(
                  selectedIcon: Icon(Icons.person_3),
                  icon: Icon(Icons.person_3_outlined),
                  label: 'Personnages',
                ),

                // Redirects to locations view
                NavigationDestination(
                  selectedIcon: Icon(Icons.place_rounded),
                  icon: Icon(Icons.place_outlined),
                  label: 'Lieux',
                ),

                // Redirects to episodes view
                NavigationDestination(
                  selectedIcon: Icon(Icons.movie),
                  icon: Icon(Icons.movie_outlined),
                  label: 'Episodes',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
