class Destination {
  final String imageUrl;
  final String name;
  final String description;
  final String price;
  final bool isAsset;
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
