import 'package:flutter/material.dart';
import 'package:hero_anim/common/utils/assets.dart';
import 'package:hero_anim/features/core/model/destination_model.dart';
import 'package:hive/hive.dart';

class DestinationProvider with ChangeNotifier {
  final List<Destination> _destinations = [
    Destination(
      imageUrl: AppAssets.kTokyo,
      name: 'Tokyo',
      description:
          '''Tokyo, the vibrant capital of Japan, is a dazzling metropolis where ancient traditions harmoniously coexist with futuristic innovations. From the serene Meiji Shrine and the historic Asakusa district with its famed Senso-ji Temple, to the neon-lit skyscrapers of Shinjuku and Shibuya's iconic scramble crossing, Tokyo offers an unparalleled urban experience. The city is a true feast for the senses, constantly evolving yet deeply rooted in its rich cultural heritage.

Explore world-class museums like the Tokyo National Museum, or lose yourself in the whimsical world of Studio Ghibli. Indulge in a culinary journey that spans from Michelin-starred restaurants to humble street food stalls serving up delicious ramen and sushi. Each of Tokyo's diverse neighborhoods, like the trendy Harajuku or the upscale Ginza, offers a unique atmosphere and countless discoveries, ensuring that every visit is filled with new adventures.

Whether you're seeking cutting-edge technology, traditional arts, vibrant nightlife, or tranquil gardens, Tokyo delivers an unforgettable experience. The efficiency of its public transport makes navigating this vast city a breeze, allowing you to fully immerse yourself in its dynamic energy and the warm hospitality of its people. Tokyo is more than just a city; it's a captivating world of its own.''',
      price: '\$1500',
      isAsset: true,
    ),
    Destination(
      imageUrl: AppAssets.kTilicho,
      name: 'Tilicho Lake',
      description:
          '''Nestled in the Annapurna mountain range of Nepal, Tilicho Lake holds the distinction of being one of the highest lakes in the world, sitting at an impressive altitude of 4,919 meters (16,138 feet). This breathtaking glacial lake is renowned for its stunning turquoise waters, which reflect the majestic snow-capped peaks that surround it, including Tilicho Peak and Annapurna III. The journey to Tilicho is as spectacular as the destination itself.

The trek to Tilicho Lake is a challenging yet incredibly rewarding adventure, typically forming a side trip from the famous Annapurna Circuit. Trekkers traverse rugged terrains, remote villages, and high mountain passes, experiencing the unique culture of the local Manangi people. The raw, untouched beauty of the landscape, with its sparse vegetation and dramatic cliffs, creates a profound sense of awe and connection with nature.

Reaching Tilicho Lake offers a moment of unparalleled tranquility and accomplishment. The serene atmosphere, combined with the panoramic views of the Himalayas, makes it a spiritual haven for many. It's a place where the grandeur of nature is on full display, leaving an indelible mark on all who make the pilgrimage to its pristine shores.''',
      price: '\$1200',
      isAsset: true,
    ),
    Destination(
      imageUrl:
         AppAssets.kEverest, 
      name: 'Mt. Everest',
      description:
          '''Mount Everest, known as Sagarmatha in Nepali and Chomolungma in Tibetan, stands as the Earth's highest mountain above sea level, soaring to an awe-inspiring 8,848.86 meters (29,031.7 feet). Located in the Mahalangur Himal sub-range of the Himalayas, its majestic peak is a symbol of ultimate adventure and human endurance, drawing climbers and trekkers from every corner of the globe to witness its grandeur.

The Everest region, or Khumbu, is not just about the summit; it's a land of dramatic glaciers, picturesque Sherpa villages, and ancient Buddhist monasteries. Treks to Everest Base Camp offer a challenging yet accessible way to experience the mountain's colossal presence, providing breathtaking views and insights into the unique Sherpa culture and their deep spiritual connection to these sacred mountains. The journey is a testament to the power of nature and the resilience of the human spirit.

For mountaineers, conquering Everest is a lifelong dream, a formidable test of skill, courage, and perseverance against extreme altitudes and harsh weather conditions. But even for those who admire it from afar or trek its foothills, Mount Everest instills a profound sense of wonder and respect for the raw, untamed beauty of the natural world, making it a truly iconic and unforgettable destination.''',
      price: '\$900',
      isAsset: true,
    ),
    Destination(
      imageUrl:
          AppAssets.kNepal, // Image path suggests Everest, name is Nepal
      name: 'Nepal',
      description:
          '''Nepal, a landlocked nation nestled in the heart of the Himalayas, is a country of breathtaking natural beauty and profound cultural richness. From the towering snow-capped peaks of the world's highest mountains, including Mount Everest, to lush subtropical forests and ancient cities teeming with history, Nepal offers an astonishing diversity of landscapes and experiences. It's a place where spirituality and adventure intertwine seamlessly.

The vibrant culture of Nepal is a tapestry woven from Hindu and Buddhist traditions, evident in its myriad temples, monasteries, and colorful festivals. The Kathmandu Valley, a UNESCO World Heritage site, is home to ancient cities like Kathmandu, Patan, and Bhaktapur, each boasting intricate wood carvings, stunning pagoda-style temples, and lively marketplaces. The warmth and hospitality of the Nepali people are renowned, making every visitor feel truly welcome.

Beyond its cultural treasures, Nepal is an adventurer's paradise. Whether it's trekking through legendary mountain trails, white-water rafting down pristine rivers, paragliding with Himalayan vistas, or exploring diverse wildlife in national parks like Chitwan, Nepal offers an adrenaline rush for every thrill-seeker. It's a destination that captivates the soul and leaves visitors with lasting memories of its majestic scenery and enduring spirit.''',
      price: '\$900',
      isAsset: true,
    ),
    Destination(
      imageUrl: AppAssets.kNewyork,
      name: 'Newyork',
      description:
          '''New York City, often called "The City That Never Sleeps," is a global powerhouse of culture, finance, fashion, and art. Its iconic skyline, dominated by architectural marvels like the Empire State Building, Chrysler Building, and One World Trade Center, is instantly recognizable. From the bustling streets of Times Square to the serene pathways of Central Park, NYC offers an electrifying blend of energy and diversity.

Each of the city's five boroughs—Manhattan, Brooklyn, Queens, The Bronx, and Staten Island—boasts its own unique character and attractions. Explore world-renowned museums such as The Metropolitan Museum of Art and the Museum of Modern Art, catch a dazzling Broadway show in the Theater District, or wander through vibrant neighborhoods like Greenwich Village, SoHo, and Chinatown. The city's culinary scene is a melting pot of global flavors, with endless options from street food to Michelin-starred dining.

New York is a city of dreams and ambitions, a place where innovation thrives and creativity flourishes. It's a hub for entrepreneurs, artists, and visionaries from around the world, contributing to its dynamic and ever-evolving atmosphere. Whether you're a first-time visitor or a seasoned traveler, NYC's magnetic charm and boundless opportunities for exploration promise an unforgettable urban adventure.''',
      price: '\$1600',
      isAsset: true,
    ),
    Destination(
      imageUrl: AppAssets.kKongkong,
      name: 'HongKong',
      description:
          '''Hong Kong, a vibrant Special Administrative Region of China, is a captivating destination renowned for its stunning skyscraper-studded skyline, deep natural harbor, and a unique fusion of Eastern and Western cultures. Victoria Harbour provides a dramatic backdrop to this bustling metropolis, especially during the nightly "A Symphony of Lights" show. The city is a dynamic financial hub, a shopper's paradise, and a culinary mecca.

Beyond its urban intensity, Hong Kong offers surprisingly beautiful natural landscapes, from scenic hiking trails like the Dragon's Back to tranquil beaches and verdant country parks. Take the historic Peak Tram for panoramic views of the city, explore traditional fishing villages like Tai O, or visit the serene Big Buddha and Po Lin Monastery on Lantau Island. The efficient public transport system, including its iconic Star Ferry, makes exploring diverse attractions easy.

Hong Kong's culinary scene is legendary, offering everything from dim sum and street food delicacies to high-end international cuisine. The city's rich colonial history and Chinese heritage blend to create a unique cultural tapestry, reflected in its festivals, temples, and bustling markets. Hong Kong is a city of contrasts, where modernity meets tradition, offering an exhilarating and multifaceted travel experience.''',
      price: '\$1500',
      isAsset: true,
    ),
    Destination(
      imageUrl: AppAssets.kMaldives,
      name: 'Maldives',
      description:
          '''The Maldives, an archipelago of over a thousand coral islands scattered across the Indian Ocean, is the epitome of a tropical paradise. Famed for its pristine white-sand beaches, crystal-clear turquoise lagoons, and luxurious overwater bungalows, it's a dream destination for honeymooners, divers, and anyone seeking ultimate relaxation and natural beauty. Each resort island offers a secluded haven of tranquility and indulgence.

Beneath the shimmering surface lies a vibrant underwater world, making the Maldives one of the world's premier snorkeling and diving destinations. Explore colorful coral reefs teeming with diverse marine life, including manta rays, whale sharks, and countless species of tropical fish. Watersports such as windsurfing, kayaking, and catamaran sailing are also popular, offering various ways to enjoy the idyllic surroundings.

The Maldivian culture, though often overshadowed by its resort experiences, is rich and unique, with influences from South Asian, Arab, and African traders. Visitors can get a glimpse of local life by visiting inhabited islands, enjoying traditional music and dance performances, or savoring local cuisine. The Maldives offers an unparalleled escape, where breathtaking beauty and serene luxury create memories to last a lifetime.''',
      price: '\$1200',
      isAsset: true,
    ),
    Destination(
      imageUrl: AppAssets.kFiji,
      name: 'Fiji',
      description:
          '''Fiji, an archipelago of more than 300 islands in the South Pacific, is a tropical dream renowned for its dazzling white-sand beaches, crystal-clear turquoise waters, and vibrant coral reefs. Known as the "Soft Coral Capital of the World," Fiji offers unparalleled snorkeling and diving experiences, with an abundance of colorful marine life and spectacular underwater seascapes. The islands are a sanctuary for those seeking sun, sand, and adventure.

The Fijian culture is rich and welcoming, characterized by the warm "Bula!" greeting that echoes throughout the islands. Visitors can experience traditional village life, witness captivating Meke (song and dance) performances, and participate in Kava ceremonies. The friendly locals and their laid-back lifestyle contribute significantly to Fiji's charm, making it a place where relaxation comes naturally.

Beyond its stunning beaches and underwater wonders, Fiji's lush interiors offer opportunities for hiking to waterfalls, exploring rainforests, and discovering hidden gems. Whether you're looking for a luxurious resort stay, a family-friendly holiday, or an adventurous escape, Fiji's diverse islands cater to all tastes, promising a blissful and unforgettable South Pacific getaway.''',
      price: '\$1700',
      isAsset: true,
    ),
    Destination(
      imageUrl:
          AppAssets.kNepal, // Same image as 'Mt.Everest' entry, but name is 'Nepal'
      name: 'Nepal',
      description:
          '''Nepal, a landlocked nation nestled in the heart of the Himalayas, is a country of breathtaking natural beauty and profound cultural richness. From the towering snow-capped peaks of the world's highest mountains, including Mount Everest, to lush subtropical forests and ancient cities teeming with history, Nepal offers an astonishing diversity of landscapes and experiences. It's a place where spirituality and adventure intertwine seamlessly.

The vibrant culture of Nepal is a tapestry woven from Hindu and Buddhist traditions, evident in its myriad temples, monasteries, and colorful festivals. The Kathmandu Valley, a UNESCO World Heritage site, is home to ancient cities like Kathmandu, Patan, and Bhaktapur, each boasting intricate wood carvings, stunning pagoda-style temples, and lively marketplaces. The warmth and hospitality of the Nepali people are renowned, making every visitor feel truly welcome.

Beyond its cultural treasures, Nepal is an adventurer's paradise. Whether it's trekking through legendary mountain trails, white-water rafting down pristine rivers, paragliding with Himalayan vistas, or exploring diverse wildlife in national parks like Chitwan, Nepal offers an adrenaline rush for every thrill-seeker. It's a destination that captivates the soul and leaves visitors with lasting memories of its majestic scenery and enduring spirit.''', // Reusing the Nepal description from earlier entry with 'Nepal' as name
      price: '\$900',
      isAsset: true,
    ),
    Destination(
      imageUrl: AppAssets.kTilicho,
      name: 'Tilicho Lake',
      description:
          '''Nestled in the Annapurna mountain range of Nepal, Tilicho Lake holds the distinction of being one of the highest lakes in the world, sitting at an impressive altitude of 4,919 meters (16,138 feet). This breathtaking glacial lake is renowned for its stunning turquoise waters, which reflect the majestic snow-capped peaks that surround it, including Tilicho Peak and Annapurna III. The journey to Tilicho is as spectacular as the destination itself.

The trek to Tilicho Lake is a challenging yet incredibly rewarding adventure, typically forming a side trip from the famous Annapurna Circuit. Trekkers traverse rugged terrains, remote villages, and high mountain passes, experiencing the unique culture of the local Manangi people. The raw, untouched beauty of the landscape, with its sparse vegetation and dramatic cliffs, creates a profound sense of awe and connection with nature.

Reaching Tilicho Lake offers a moment of unparalleled tranquility and accomplishment. The serene atmosphere, combined with the panoramic views of the Himalayas, makes it a spiritual haven for many. It's a place where the grandeur of nature is on full display, leaving an indelible mark on all who make the pilgrimage to its pristine shores.''', // Reusing Tilicho Lake description
      price: '\$1200',
      isAsset: true,
    ),
    Destination(
      imageUrl: AppAssets.kTokyo,
      name: 'Tokyo',
      description:
          '''Tokyo, Japan's bustling capital, masterfully blends the ultramodern with the traditional, from neon-illuminated skyscrapers to historic temples. This megacity is a hub of innovation, setting trends in fashion, technology, and cuisine while meticulously preserving its ancient cultural roots. The sheer scale and energy of Tokyo are mesmerizing, offering endless exploration opportunities for every type of traveler.

Dive into the city's rich artistic heritage at the Ueno Park museums, witness the precision of a traditional tea ceremony, or experience the vibrant pop culture of Akihabara. Tokyo's food scene is legendary, offering everything from the freshest sushi at the Toyosu Fish Market to delectable street food and world-class fine dining. Each neighborhood tells a different story, creating a diverse and captivating urban tapestry.

Beyond its iconic landmarks like the Tokyo Skytree and the Imperial Palace, Tokyo’s charm lies in its smaller details: serene gardens hidden amidst concrete jungles, meticulously crafted goods, and the polite efficiency of its residents. It’s a city that constantly reinvents itself, ensuring that every visit uncovers new facets of its dynamic personality, making it an endlessly fascinating destination.''', // Second Tokyo entry, slightly different focus
      price: '\$1250',
      isAsset: true,
    ),
    Destination(
      imageUrl: AppAssets.kMaldives,
      name: 'Maldives',
      description:
          '''The Maldives, a stunning chain of atolls in the Indian Ocean, beckons with its idyllic vision of paradise: powdery white sands, swaying palm trees, and impossibly clear turquoise waters. This tropical haven is synonymous with luxury and tranquility, offering exclusive resort experiences where overwater villas provide direct access to the vibrant marine life below. It's the perfect escape for romance, relaxation, and reconnecting with nature.

Explore the breathtaking coral reefs that make the Maldives a world-class destination for snorkeling and diving. Swim alongside graceful manta rays, gentle whale sharks, and a kaleidoscope of colorful fish in the warm, inviting waters. For those seeking adventure above the waves, activities like sunset cruises, dolphin watching, and various watersports offer thrilling ways to experience the archipelago's natural splendor.

Beyond the luxurious resorts, the Maldivian culture offers a unique island charm. Discover local traditions, savor fresh seafood infused with regional spices, and enjoy the laid-back pace of island life. The Maldives is more than just a picturesque postcard; it's an immersive experience that rejuvenates the senses and creates cherished memories of sun-drenched days and starlit nights.''', // Second Maldives entry, slightly different focus
      price: '\$1500',
      isAsset: true,
    ),
    Destination(
      imageUrl: AppAssets.kKili,
      name: 'Mt.Kilimanjaro',
      description:
          '''The Maldives, a stunning chain of atolls in the Indian Ocean, beckons with its idyllic vision of paradise: powdery white sands, swaying palm trees, and impossibly clear turquoise waters. This tropical haven is synonymous with luxury and tranquility, offering exclusive resort experiences where overwater villas provide direct access to the vibrant marine life below. It's the perfect escape for romance, relaxation, and reconnecting with nature.

Explore the breathtaking coral reefs that make the Maldives a world-class destination for snorkeling and diving. Swim alongside graceful manta rays, gentle whale sharks, and a kaleidoscope of colorful fish in the warm, inviting waters. For those seeking adventure above the waves, activities like sunset cruises, dolphin watching, and various watersports offer thrilling ways to experience the archipelago's natural splendor.

Beyond the luxurious resorts, the Maldivian culture offers a unique island charm. Discover local traditions, savor fresh seafood infused with regional spices, and enjoy the laid-back pace of island life. The Maldives is more than just a picturesque postcard; it's an immersive experience that rejuvenates the senses and creates cherished memories of sun-drenched days and starlit nights.''', // Second Maldives entry, slightly different focus
      price: '\$1250',
      isAsset: true,
    ),
  ];

  // Using hive as persistence storage
  final Box<Destination> _favoritesBox = Hive.box<Destination>('favorites');

  List<Destination> get destinations => _destinations;

  // Adding favorites to list
  List<Destination> get favoriteDestinations {
    return _favoritesBox.values.toList();
  }

  // destination remove if fav/add if not
  void toggleFavorite(Destination destination) {
    destination.isFavorite = !destination.isFavorite;

    if (destination.isFavorite) {
      _addToFavorites(destination);
    } else {
      _removeFromFavorites(destination);
    }
    notifyListeners();
  }

  void _addToFavorites(Destination destination) {
    // Check if already exists to avoid duplicates
    if (!_favoritesBox.values.any((d) => d.imageUrl == destination.imageUrl)) {
      _favoritesBox.add(destination);
    }
  }

  void _removeFromFavorites(Destination destination) {
    // Find the key for this destination
    final key = _favoritesBox.keys.firstWhere(
      (k) => _favoritesBox.get(k)?.imageUrl == destination.imageUrl,
      orElse: () => null,
    );

    if (key != null) {
      _favoritesBox.delete(key);
    }
  }

  // Check if a destination is favorite
  bool isFavorite(Destination destination) {
    return _favoritesBox.values.any((d) => d.imageUrl == destination.imageUrl);
  }

  // Load favorites status when app starts
  void loadFavoritesStatus() {
    for (var destination in _destinations) {
      destination.isFavorite = isFavorite(destination);
    }
    notifyListeners();
  }
}
