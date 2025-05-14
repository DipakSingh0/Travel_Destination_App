import 'package:hero_anim/features/core/model/category_model.dart';
import 'package:hero_anim/imports.dart';

class CategoryProvider with ChangeNotifier {
  final List<Category> _categories = [
    Category(
      name: 'Mountains',
      imageUrl: AppAssets.kEverest,
      isAsset: true,
      items: {
        'Everest': CategoryItem(
          name: 'Everest',
          imageUrl: AppAssets.kEverest,
          description:
              '''Mount Everest, known as Sagarmatha in Nepali and Chomolungma in Tibetan, stands as the Earth's highest mountain above sea level, soaring to an awe-inspiring 8,848.86 meters (29,031.7 feet). Located in the Mahalangur Himal sub-range of the Himalayas, its majestic peak is a symbol of ultimate adventure and human endurance, drawing climbers and trekkers from every corner of the globe to witness its grandeur.

The Everest region, or Khumbu, is not just about the summit; it's a land of dramatic glaciers, picturesque Sherpa villages, and ancient Buddhist monasteries. Treks to Everest Base Camp offer a challenging yet accessible way to experience the mountain's colossal presence, providing breathtaking views and insights into the unique Sherpa culture and their deep spiritual connection to these sacred mountains. The journey is a testament to the power of nature and the resilience of the human spirit.

For mountaineers, conquering Everest is a lifelong dream, a formidable test of skill, courage, and perseverance against extreme altitudes and harsh weather conditions. But even for those who admire it from afar or trek its foothills, Mount Everest instills a profound sense of wonder and respect for the raw, untamed beauty of the natural world, making it a truly iconic and unforgettable destination.''',
          price: '\$900',
        ),
        'Kilimanjaro': CategoryItem(
          name: 'Kilimanjaro',
          imageUrl: AppAssets.kKili,
          description: 'The highest mountain in Africa...',
          price: '\$1500',
        ),
        'Fuji': CategoryItem(
          name: 'Fuji',
          imageUrl: AppAssets.kFuji,
          description: 'A well-known active stratovolcano...',
          price: '\$1200',
        ),
      },
    ),
    Category(
      name: 'Lakes',
      imageUrl: AppAssets.kTilicho,
      isAsset: true,
      items: {
        'Lake Baikal': CategoryItem(
          name: 'Lake Baikal',
          imageUrl:  AppAssets.kBaikal,
          description: 'The world\'s largest freshwater lake...',
          price: '\$800',
        ),
        'Caspian Sea': CategoryItem(
          name: 'Caspian Sea',
          imageUrl:  AppAssets.kCaspian,
          description: 'The world\'s largest landlocked body of water...',
          price: '\$1000',
        ),
        'Tilicho': CategoryItem(
          name: 'Tilicho',
          imageUrl:  AppAssets.kTilicho,
          description: 'A high-altitude lake in the Annapurna range...',
          price: '\$900',
        ),
      },
    ),
    Category(
      name: 'Cities',
      imageUrl: AppAssets.kTokyo,
      isAsset: true,
      items: {
        'Tokyo': CategoryItem(
          name: 'Tokyo',
          imageUrl:  AppAssets.kTokyo1,
          description: 'The capital city of Japan...',
          price: '\$1500',
        ),
        'Hong Kong': CategoryItem(
          name: 'Hong Kong',
          imageUrl:  AppAssets.kKongkong,
          description: 'A special administrative region of China...',
          price: '\$1800',
        ),
        'New York': CategoryItem(
          name: 'New York',
          imageUrl: AppAssets.kNewyork,
          description: 'The most populous city in the United States...',
          price: '\$2000',
        ),
      },
    ),
    Category(
      name: 'Countries',
      imageUrl: AppAssets.kUk,
      isAsset: true,
      items: {
        'Nepal': CategoryItem(
          name: 'Nepal',
          imageUrl: AppAssets.kNepal,
          description: 'A landlocked country in South Asia...',
          price: '\$1000',
        ),
        'Switzerland': CategoryItem(
          name: 'Switzerland',
          imageUrl:  AppAssets.kSwitzerland,
          description: 'A mountainous country in central Europe...',
          price: '\$1200',
        ),
        'UK': CategoryItem(
          name: 'UK',
          imageUrl: AppAssets.kUk,
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
