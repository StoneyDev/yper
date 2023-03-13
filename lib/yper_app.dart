import 'package:flutter/material.dart';
import 'package:yper/data/repositories/episode_repository.dart';

class YperApp extends StatelessWidget {
  const YperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick et Morty',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Rick et Morty')),
        body: FutureBuilder(
          future: EpisodeRepository().getAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.all(20),
                children: snapshot.data!.map((e) => Text(e.name)).toList(),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
