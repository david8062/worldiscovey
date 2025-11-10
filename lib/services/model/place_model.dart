class Place {
  final String placeId;
  final String name;
  final double latitude;
  final double longitude;
  final String? photoReference;
  final String? openingHours;
  final String? description;

  Place({
    required this.placeId,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.photoReference,
    this.openingHours,
    this.description,
  });
}
