import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../services/model/place_model.dart';
import '../viewModel/map_view_model.dart';

class MapView extends StatefulWidget {
  final String placeType;

  const MapView({super.key, required this.placeType});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? mapController;
  final LatLng userLocation = const LatLng(4.7110, -74.0721);
  final MapViewModel _viewModel = MapViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.onUpdate = () => setState(() {});
    _loadPlaces();
  }

  Future<void> _loadPlaces() async {
    await _viewModel.loadPlaces(widget.placeType, userLocation);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapa de ${widget.placeType}")),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              setState(() => mapController = controller);
            },
            initialCameraPosition: CameraPosition(
              target: userLocation,
              zoom: 14,
            ),
            markers: _viewModel.markers,
            polylines: _viewModel.polylines,
          ),

          if (_viewModel.selectedPlace != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildPlaceCard(_viewModel.selectedPlace!),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceCard(Place place) {
    return Card(
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                place.photoReference ?? "https://via.placeholder.com/300",
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12),

            Text(
              place.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            if (place.description != null)
              Text(place.description!),

            if (place.openingHours != null)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  "Horario: ${place.openingHours}",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                _viewModel.drawRoute(userLocation);
              },
              child: Text("Ir ahora"),
            )
          ],
        ),
      ),
    );
  }

}
