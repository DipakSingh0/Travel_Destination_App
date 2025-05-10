// model/category_model.dart
class CategoryItem {
  final String name;
  final String imageUrl;
  final String description;
  final String price;
  bool isFavorite;

  CategoryItem({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.isFavorite = false,
  });
}

class Category {
  final String name;
  final String imageUrl;
  final bool isAsset;
  final Map<String, CategoryItem> items;

  Category({
    required this.name,
    required this.items,
    required this.imageUrl,
    this.isAsset = false,
  });
}
