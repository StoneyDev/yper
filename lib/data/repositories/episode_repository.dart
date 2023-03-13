import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:yper/data/helpers/http_helper.dart';
import 'package:yper/data/model/episode.dart';

class EpisodeRepository {
  Future<List<Episode>> getAll() async {
    final Uri url = Uri.parse(HttpClient.episodesEndpoint);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final episodes = List<Map<String, dynamic>>.from(jsonDecode(res.body)['results']);

      return (episodes).map((e) => Episode.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch episodes');
    }
  }

  Future<Episode> getInfos(int id) async {
    final Uri url = Uri.parse('${HttpClient.episodesEndpoint}/$id');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return Episode.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to fetch character: $id');
    }
  }
}
