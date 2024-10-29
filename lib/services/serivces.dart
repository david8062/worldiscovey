import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/service_model.dart';

class ServiceMaps {
  final String apiKey = "AIzaSyA2dsaYl7s411DeFkErCP8cKnpV0t_E2f4";

  Future<List<Place>> getNearbyPlaces(String type, double lat, double lng) async {
    //final url ='https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=500&type=$type&key=$apiKey';
    final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=500&type=$type&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<Place> places = (data['results'] as List).map((placeJson) {
        print("La url de la peticion es $url");
        return Place(
          name: placeJson['name'],
          latitude: placeJson['geometry']['location']['lat'],
          longitude: placeJson['geometry']['location']['lng'],
        );
      }).toList();

      return places;
    } else {
      throw Exception('Error al obtener lugares');
    }
  }
}



