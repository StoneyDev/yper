import 'package:flutter/material.dart';
import 'package:yper/features/episodes/models/episode.dart';
import 'package:yper/features/episodes/models/episode_repository.dart';

class EpisodeViewModel extends ChangeNotifier {
  List<Episode> _episodes = [];

  bool _isLoading = false;

  // Getter
  List<Episode> get episodes => _episodes;
  bool get isLoading => _isLoading;

  Future<List<Episode>> fetchEpisodes() async {
    final EpisodeRepository episodeRepository = EpisodeRepository();

    try {
      // Start loading
      _isLoading = !_isLoading;

      notifyListeners();

      // Fetch locations
      _episodes = await episodeRepository.getAll();

      // Stop loading
      _isLoading = !_isLoading;

      notifyListeners();
    } catch (e) {
      //
    }

    return _episodes;
  }
}
