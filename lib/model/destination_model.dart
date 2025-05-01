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

  Destination(
    this.imageUrl,
    this.name,
    this.description,
    this.price,
    this.isAsset, {
    this.isFavorite = false,
  });
}

// class Destination {
//   final String imageUrl;
//   final String name;
//   final String description;
//   final String price;
//   final bool isAsset;
//   bool isFavorite;

//   Destination(
//     this.imageUrl,
//     this.name,
//     this.description,
//     this.price,
//     this.isAsset, {
//     this.isFavorite = false,
//   });
// }
