import 'package:hero_anim/imports.dart';

class CategoryProvider with ChangeNotifier {
  final List<Category> _categories = [
    Category(
      name: 'Mountains',
     
      items: {
        'Everest': CategoryItem(
            name: 'Everest',
            imageUrl: AppAssets.kEverest,
            description:
                '''Mount Everest, known as Sagarmatha in Nepali and Chomolungma in Tibetan, stands as the Earth's highest mountain above sea level, soaring to an awe-inspiring 8,848.86 meters (29,031.7 feet). Located in the Mahalangur Himal sub-range of the Himalayas, its majestic peak is a symbol of ultimate adventure and human endurance, drawing climbers and trekkers from every corner of the globe to witness its grandeur.

The Everest region, or Khumbu, is not just about the summit; it's a land of dramatic glaciers, picturesque Sherpa villages, and ancient Buddhist monasteries. Treks to Everest Base Camp offer a challenging yet accessible way to experience the mountain's colossal presence, providing breathtaking views and insights into the unique Sherpa culture and their deep spiritual connection to these sacred mountains. The journey is a testament to the power of nature and the resilience of the human spirit.

For mountaineers, conquering Everest is a lifelong dream, a formidable test of skill, courage, and perseverance against extreme altitudes and harsh weather conditions. But even for those who admire it from afar or trek its foothills, Mount Everest instills a profound sense of wonder and respect for the raw, untamed beauty of the natural world, making it a truly iconic and unforgettable destination.''',
            price: '\$900',
            rating: 4.9,
            latitude: 27.9881,
            longitude: 86.9250),
        'Kilimanjaro': CategoryItem(
          name: 'Kilimanjaro',
          imageUrl: AppAssets.kKili,
          description: 'The highest mountain in Africa...',
          price: '\$1500',
          rating: 4.7,
          latitude: -3.0674,
          longitude: 37.3556,
        ),
        'Fuji': CategoryItem(
          name: 'Fuji',
          imageUrl: AppAssets.kFuji,
          description: 'A well-known active stratovolcano...',
          price: '\$1200',
          rating: 4.6,
          latitude: -17.7134,
          longitude: 178.0650,
        ),
      },
    ),
    Category(
      name: 'Lakes',
      
      items: {
        'Lake Baikal': CategoryItem(
            name: 'Lake Baikal',
            imageUrl: AppAssets.kBaikal,
            description: 'The world\'s largest freshwater lake...',
            price: '\$800',
            rating: 4.7,
        latitude: 53.5000,
        longitude: 108.0000,
            ),
        'Caspian Sea': CategoryItem(
          name: 'Caspian Sea',
          imageUrl: AppAssets.kCaspian,
          description: 'The world\'s largest landlocked body of water...',
          price: '\$1000',
          rating: 4.5,
        latitude: 41.6667,
        longitude: 50.6667,
          
        ),
        'Tilicho': CategoryItem(
          name: 'Tilicho',
          imageUrl: AppAssets.kTilicho,
          description: 'A high-altitude lake in the Annapurna range...',
          price: '\$900',
          rating: 4.7,
          latitude: 28.6855,
          longitude: 83.9492,
        ),
      },
    ),
    Category(
      name: 'Cities',
      
      items: {
        'Tokyo': CategoryItem(
            name: 'Tokyo',
            imageUrl: AppAssets.kTokyo1,
            description:  '''Tokyo, Japan's bustling capital, masterfully blends the ultramodern with the traditional, from neon-illuminated skyscrapers to historic temples. This megacity is a hub of innovation, setting trends in fashion, technology, and cuisine while meticulously preserving its ancient cultural roots. The sheer scale and energy of Tokyo are mesmerizing, offering endless exploration opportunities for every type of traveler.

Dive into the city's rich artistic heritage at the Ueno Park museums, witness the precision of a traditional tea ceremony, or experience the vibrant pop culture of Akihabara. Tokyo's food scene is legendary, offering everything from the freshest sushi at the Toyosu Fish Market to delectable street food and world-class fine dining. Each neighborhood tells a different story, creating a diverse and captivating urban tapestry.

Beyond its iconic landmarks like the Tokyo Skytree and the Imperial Palace, Tokyo’s charm lies in its smaller details: serene gardens hidden amidst concrete jungles, meticulously crafted goods, and the polite efficiency of its residents. It’s a city that constantly reinvents itself, ensuring that every visit uncovers new facets of its dynamic personality, making it an endlessly fascinating destination.''',
            price: '\$1500',
            rating: 4.8,
            latitude: 35.6762,
            longitude: 139.6503,
            ),
        'Hong Kong': CategoryItem(
          name: 'Hong Kong',
          imageUrl: AppAssets.kKongkong,
          description: 'A special administrative region of China...',
          price: '\$1800',
          rating: 4.5,
          latitude: 22.3193,
          longitude: 114.1694,
        ),
        'New York': CategoryItem(
          name: 'New York',
          imageUrl: AppAssets.kNewyork,
          description: 'The most populous city in the United States...',
          price: '\$2000',
          rating: 4.7,
          latitude: 40.7128,
          longitude: -74.0060,
        ),
      },
    ),
    Category(
      name: 'Countries',
      
      items: {
        'Nepal': CategoryItem(
          name: 'Nepal',
          imageUrl: AppAssets.kNepal,
          description: 'A landlocked country in South Asia...',
          price: '\$1000',
          rating: 4.6,
          latitude: 27.7172,
          longitude: 85.3240,
        ),
        'Switzerland': CategoryItem(
          name: 'Switzerland',
          imageUrl: AppAssets.kSwitzerland,
          description: 'A mountainous country in central Europe...',
          price: '\$1200',
          rating: 4.8,
        latitude: 46.8182,
        longitude: 8.2275,
        ),
        'UK': CategoryItem(
          name: 'UK',
          imageUrl: AppAssets.kUk,
          description:
              'A sovereign country located off the northwestern coast of the European mainland...',
          price: '\$1500',
          rating: 4.6,
        latitude: 55.3781,
        longitude: -3.4360,
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
