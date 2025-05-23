// model/category_model.dart
class CategoryItem {
  final String name;
  final String imageUrl;
  final String description;
  final String price;
  bool isFavorite;
  final double rating;
  final double latitude;
  final double longitude;

  CategoryItem({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.isFavorite = false,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });
}

class Category {
  final String name;
  final Map<String, CategoryItem> items;

  Category({
    required this.name,
    required this.items,
  });
}