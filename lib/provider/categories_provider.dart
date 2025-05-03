import 'package:flutter/material.dart';
import 'package:hero_anim/model/category_model.dart';

class CategoryProvider with ChangeNotifier {
  final List<Category> _categories = [
    Category(
      name: 'Mountains',
      imageUrl: 'assets/images/mountain/everest.webp',
      isAsset: true,
      items: {
        'Everest': CategoryItem(
          name: 'Everest',
          imageUrl: 'assets/images/mountain/everest.webp',
          description: 'The highest mountain in the world...',
          price: '\$2000',
        ),
        'Kilimanjaro': CategoryItem(
          name: 'Kilimanjaro',
          imageUrl: 'assets/images/mountain/kiliminjaro.webp',
          description: 'The highest mountain in Africa...',
          price: '\$1500',
        ),
        'Fuji': CategoryItem(
          name: 'Fuji',
          imageUrl: 'assets/images/mountain/fuji.webp',
          description: 'A well-known active stratovolcano...',
          price: '\$1200',
        ),
      },
    ),
    Category(
      name: 'Lakes',
      imageUrl: 'assets/images/lake/tilicho.webp',
      isAsset: true,
      items: {
        'Lake Baikal': CategoryItem(
          name: 'Lake Baikal',
          imageUrl: 'assets/images/lake/baikal.webp',
          description: 'The world\'s largest freshwater lake...',
          price: '\$800',
        ),
        'Caspian Sea': CategoryItem(
          name: 'Caspian Sea',
          imageUrl: 'assets/images/lake/caspian.webp',
          description: 'The world\'s largest landlocked body of water...',
          price: '\$1000',
        ),
        'Tilicho': CategoryItem(
          name: 'Tilicho',
          imageUrl: 'assets/images/lake/tilicho.webp',
          description: 'A high-altitude lake in the Annapurna range...',
          price: '\$900',
        ),
      },
    ),
    Category(
      name: 'Cities',
      imageUrl: 'assets/images/city/tokyo.png',
      isAsset: true,
      items: {
        'Tokyo': CategoryItem(
          name: 'Tokyo',
          imageUrl: 'assets/images/city/tokyo1.webp',
          description: 'The capital city of Japan...',
          price: '\$1500',
        ),
        'Hong Kong': CategoryItem(
          name: 'Hong Kong',
          imageUrl: 'assets/images/city/hongkong.webp',
          description: 'A special administrative region of China...',
          price: '\$1800',
        ),
        'New York': CategoryItem(
          name: 'New York',
          imageUrl: 'assets/images/city/newyork.webp',
          description: 'The most populous city in the United States...',
          price: '\$2000',
        ),
      },
    ),
    Category(
      name: 'Countries',
      imageUrl: 'assets/images/country/uk.png',
      isAsset: true,
      items: {
        'Nepal': CategoryItem(
          name: 'Nepal',
          imageUrl: 'assets/images/country/nepal.png',
          description: 'A landlocked country in South Asia...',
          price: '\$1000',
        ),
        'Switzerland': CategoryItem(
          name: 'Switzerland',
          imageUrl: 'assets/images/country/switzerland.webp',
          description: 'A mountainous country in central Europe...',
          price: '\$1200',
        ),
        'UK': CategoryItem(
          name: 'UK',
          imageUrl: 'assets/images/country/uk.webp',
          description:
              'A sovereign country located off the northwestern coast of the European mainland...',
          price: '\$1500',
        ),
      },
    ),
  ];

  List<Category> get categories => _categories;

  void toggleFavorite(String categoryName, String itemName) {
    final category = _categories.firstWhere((cat) => cat.name == categoryName);
    final item = category.items[itemName];
    if (item != null) {
      item.isFavorite = !item.isFavorite;
      notifyListeners();
    }
  }

  CategoryItem? getItem(String categoryName, String itemName) {
    try {
      return _categories
          .firstWhere((cat) => cat.name == categoryName)
          .items[itemName];
    } catch (e) {
      return null;
    }
  }
}
