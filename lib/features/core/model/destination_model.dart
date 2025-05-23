import 'package:hive/hive.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'destination_model.g.dart';

@HiveType(typeId: 0)
class Destination {
  @HiveField(0)
  final String imageUrl;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String price;

  @HiveField(4)
  final bool isAsset;

  @HiveField(5)
  bool isFavorite;

  @HiveField(6)
  final double rating; 

  @HiveField(7)
  final double latitude; 

  @HiveField(8)
  final double longitude; 

  Destination({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.isAsset,
    required this.rating,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
  })  : assert(rating >= 0 && rating <= 5, 'Rating must be between 0 and 5'),
        assert(latitude >= -90 && latitude <= 90, 'Invalid latitude value'),
        assert(longitude >= -180 && longitude <= 180, 'Invalid longitude value');

  // Helper getter to convert coordinates to LatLng for maps
  LatLng get location => LatLng(latitude, longitude);

  // Helper getter for formatted rating display
  String get formattedRating => '${rating.toStringAsFixed(1)} ⭐';

  Destination copyWith({
    String? imageUrl,
    String? name,
    String? description,
    String? price,
    bool? isAsset,
    bool? isFavorite,
    double? rating,
    double? latitude,
    double? longitude,
  }) {
    return Destination(
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      isAsset: isAsset ?? this.isAsset,
      isFavorite: isFavorite ?? this.isFavorite,
      rating: rating ?? this.rating,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}