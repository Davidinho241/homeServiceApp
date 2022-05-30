import 'dart:convert';

import 'package:home_service/src/models/LocationModel.dart';
import 'package:http/http.dart' as http;

class LocationService {
  Future<List<LocationModel>> fetchLocations(String keyword) async {
    try {
      var url =
          'https://api.mapbox.com/geocoding/v5/mapbox.places/$keyword.json?access_token=pk.eyJ1IjoiaW5vb3JleGkiLCJhIjoiY2p6OWozaW1qMXdvNzNvbTJqdzRnZTBkNCJ9.tnXHDq0_ZB_O8qA2m9k5iQ&autocomplete=true';
      var response = await http.get(Uri.parse(url));
      final res = json.decode(response.body);
      List<LocationModel> locations = List<LocationModel>();
      res["features"].forEach((loc) {
        var dummy = LocationModel.fromJson(loc);
        locations.add(dummy);
      });
      return locations;
    } catch (e) {
      return null;
    }
  }
}
