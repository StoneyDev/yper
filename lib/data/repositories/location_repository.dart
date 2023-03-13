import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:yper/data/helpers/http_helper.dart';
import 'package:yper/data/model/location.dart';

class LocationRepository {
  Future<List<Location>> getAll() async {
    final Uri url = Uri.parse(HttpClient.locationsEndpoint);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final locations = List<Map<String, dynamic>>.from(jsonDecode(res.body)['results']);

      return locations.map((e) => Location.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch locations');
    }
  }

  Future<Location> getInfos(int id) async {
    final Uri url = Uri.parse('${HttpClient.locationsEndpoint}/$id');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return Location.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to fetch location: $id');
    }
  }
}
