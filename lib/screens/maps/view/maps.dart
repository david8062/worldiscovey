import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../viewModel/map_view_model.dart';


class MapView extends StatefulWidget {

  final String placeType;

  const MapView({super.key, required this.placeType});

  @override
  _MapViewState createState() => _MapViewState();
}


class _MapViewState extends State<MapView> {
  GoogleMapController? mapController;
  final LatLng userLocation = const LatLng(4.7110, -74.0721); // Bogotá, ejemplo
  final MapViewModel _viewModel = MapViewModel(); // Instancia directa de ViewModel

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  Future<void> _loadPlaces() async {
    await _viewModel.loadPlaces(widget.placeType, userLocation);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("Lugar buscado: ${widget.placeType}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de ${widget.placeType}'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: userLocation,
          zoom: 14,
        ),
        markers: _viewModel.markers,
      ),
    );
  }
}
