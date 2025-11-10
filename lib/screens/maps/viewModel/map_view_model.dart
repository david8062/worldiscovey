import 'package:flutter/animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../services/model/place_model.dart';
import '../../../services/serivces.dart';

class MapViewModel {
  VoidCallback? onUpdate;

  Place? selectedPlace;

  final ServiceMaps _placesService = ServiceMaps();

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  /// =============================================
  /// 1. Cargar lugares cercanos
  /// =============================================
  Future<void> loadPlaces(String placeType, LatLng userLocation) async {
    markers = {
      Marker(
        markerId: const MarkerId("user"),
        position: userLocation,
      ),
    };

    final places = await _placesService.getNearbyPlaces(
      placeType,
      userLocation.latitude,
      userLocation.longitude,
    );

    markers.addAll(
      places.map(
            (place) => Marker(
          markerId: MarkerId(place.placeId),
          position: LatLng(place.latitude, place.longitude),
          infoWindow: InfoWindow(title: place.name),
          onTap: () {
            selectedPlace = place;
            polylines.clear(); // limpiamos rutas anteriores
            onUpdate?.call();
          },
        ),
      ),
    );

    onUpdate?.call();
  }

  /// =============================================
  /// 2. Dibujar la ruta hacia el lugar seleccionado
  /// =============================================
  Future<void> drawRoute(LatLng origin) async {
    if (selectedPlace == null) return;

    final dest = LatLng(selectedPlace!.latitude, selectedPlace!.longitude);

    final points = await _placesService.getRoutePoints(
      origin.latitude,
      origin.longitude,
      dest.latitude,
      dest.longitude,
    );

    if (points.isEmpty) return;

    polylines = {
      Polyline(
        polylineId: const PolylineId("route"),
        points: points,
        width: 6,
        color: const Color(0xFF0D47A1), // azul bonito
      ),
    };

    onUpdate?.call();
  }
}
