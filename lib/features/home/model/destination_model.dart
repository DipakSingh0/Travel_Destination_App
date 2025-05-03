import 'package:hive/hive.dart';

part 'destination_model.g.dart'; 

@HiveType(typeId: 0)   // using hive as local storage for favorites
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


  Destination({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.isAsset,
    this.isFavorite = false,
  });

  Destination copyWith({
    String? imageUrl,
    String? name,
    String? description,
    String? price,
    bool? isAsset,
    bool? isFavorite,
  }) {
    return Destination(
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      isAsset: isAsset ?? this.isAsset,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

}
