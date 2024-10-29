import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../services/model/service_model.dart';
import '../../../services/serivces.dart';

class MapViewModel {
  final ServiceMaps _placesService = ServiceMaps();
  Set<Marker> markers = {};

  Future<void> loadPlaces(String placeType, LatLng userLocation) async {
    List<Place> places = await _placesService.getNearbyPlaces(
        placeType, userLocation.latitude, userLocation.longitude);

    print('Lugares obtenidos: $places'); // Agrega esta línea

    markers = places.map((place) {
      return Marker(
        markerId: MarkerId(place.name),
        position: LatLng(place.latitude, place.longitude),
        infoWindow: InfoWindow(title: place.name),
      );
    }).toSet();
  }

}
