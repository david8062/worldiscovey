import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/place_model.dart';

class ServiceMaps {
  final String apiKey = "AIzaSyB_t6An2045RZbdgWI4gbPTKp4vWNHrrCA";

  /// ----------------------------------------------------------
  /// NEARBY SEARCH + DETAILS
  /// ----------------------------------------------------------
  Future<List<Place>> getNearbyPlaces(
      String type, double lat, double lng) async {

    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=500&type=$type&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception("Error al obtener lugares");
    }

    final data = json.decode(response.body);
    final results = (data["results"] ?? []) as List;

    List<Place> places = [];

    for (var placeJson in results) {
      final placeId = placeJson["place_id"];
      final details = await getPlaceDetails(placeId);

      places.add(
        Place(
          placeId: placeId,
          name: placeJson["name"],
          latitude: placeJson["geometry"]["location"]["lat"],
          longitude: placeJson["geometry"]["location"]["lng"],
          photoReference: details["photo"],
          openingHours: details["openingHours"],
          description: details["description"],
        ),
      );
    }

    return places;
  }

  /// ----------------------------------------------------------
  /// PLACE DETAILS
  /// ----------------------------------------------------------
  Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=name,opening_hours,photos,editorial_summary&key=$apiKey";

    final resp = await http.get(Uri.parse(url));

    if (resp.statusCode != 200) return {};

    final jsonData = json.decode(resp.body);
    final result = jsonData["result"];

    if (result == null) return {};

    // Foto
    String? photoUrl;
    if (result["photos"] != null && result["photos"].isNotEmpty) {
      final ref = result["photos"][0]["photo_reference"];
      photoUrl =
      "https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=$ref&key=$apiKey";
    }

    return {
      "photo": photoUrl,
      "openingHours": result["opening_hours"]?["weekday_text"]?.join(" | "),
      "description": result["editorial_summary"]?["overview"],
    };
  }

  /// ----------------------------------------------------------
  /// DIRECTIONS
  /// ----------------------------------------------------------
  Future<List<LatLng>> getRoutePoints(
      double originLat,
      double originLng,
      double destLat,
      double destLng,
      ) async {
    final url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$originLat,$originLng&destination=$destLat,$destLng&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) return [];

    final data = json.decode(response.body);

    if (data["routes"].isEmpty) return [];

    final points = data["routes"][0]["overview_polyline"]["points"];

    return decodePolyline(points);
  }

  /// ----------------------------------------------------------
  /// POLYLINE DECODER
  /// ----------------------------------------------------------
  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat =
      (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng =
      (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      poly.add(
        LatLng(lat / 1E5, lng / 1E5),
      );
    }
    return poly;
  }
}
