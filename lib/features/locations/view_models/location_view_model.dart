import 'package:flutter/material.dart';
import 'package:yper/features/locations/models/location.dart';
import 'package:yper/features/locations/models/location_repository.dart';

class LocationViewModel extends ChangeNotifier {
  List<Location> _locations = [];

  bool _isLoading = false;

  // Getter
  List<Location> get locations => _locations;
  bool get isLoading => _isLoading;

  Future<List<Location>> fetchLocations() async {
    final LocationRepository locationRepository = LocationRepository();

    try {
      // Start loading
      _isLoading = !_isLoading;

      notifyListeners();

      // Fetch locations
      _locations = await locationRepository.getAll();

      // Stop loading
      _isLoading = !_isLoading;

      notifyListeners();
    } catch (e) {
      //
    }

    return _locations;
  }
}
