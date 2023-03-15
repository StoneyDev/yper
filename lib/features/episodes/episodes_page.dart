import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yper/features/episodes/view_models/episode_view_model.dart';

class EpisodesPage extends StatelessWidget {
  const EpisodesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EpisodeViewModel>(
      create: (_) => EpisodeViewModel()..fetchEpisodes(),
      child: Consumer<EpisodeViewModel>(
        builder: (context, value, child) {
          // Loading widget
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Displaying data
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: value.episodes.length,
            itemBuilder: (context, index) => Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and airDate properties
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            value.episodes[index].name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        if (value.episodes[index].airDate != null)
                          Text(
                            value.episodes[index].airDate ?? 'N/A',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
