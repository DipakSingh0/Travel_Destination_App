import 'package:flutter/material.dart';
import 'package:hero_anim/model/destination_model.dart';
import 'package:hive/hive.dart';

class DestinationProvider with ChangeNotifier {
  final List<Destination> _destinations = [
    Destination(
      imageUrl: 'assets/images/city/Tokyo.png',
      name: 'Tokyo',
      description: 'Beautiful Skyscrappers',
      price: '\$1500',
      isAsset: true,
    ),
    Destination(
      imageUrl: 'assets/images/lake/tilicho.webp',
      name: 'Tilicho Lake',
      description: 'Highest Lake in the World Located in Nepal.',
      price: '\$1200',
      isAsset: true,
    ),
    Destination(
      imageUrl: 'assets/images/country/nepal.png',
      name: 'Mt.Everest',
      description: 'Country of the Gods with vibrant culture.',
      price: '\$900',
      isAsset: true,
    ),
    Destination(
      imageUrl: 'assets/images/mountain/everest.webp',
      name: 'Nepal',
      description: 'Country of the Gods with vibrant culture.',
      price: '\$900',
      isAsset: true,
    ),
    Destination(
      imageUrl: 'assets/images/city/newyork.webp',
      name: 'Newyork',
      description: 'Country of the Skyscrappers with Enterpreneurs.',
      price: '\$1600',
      isAsset: true,
    ),
     Destination(
      imageUrl:'assets/images/city/hongkong.webp',
      
      name: 'HongKong',
      description: 'Beautiful Skyscrappers',
      price: '\$1500',
      isAsset: true,
    ),
    // Destination(
    //   imageUrl:
    //       'https://imgs.search.brave.com/2sk2J7cfOUGZgv9akDJIjakOfdmKEY3pjDdVE5qhYYY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAyLzE5LzgxLzMx/LzM2MF9GXzIxOTgx/MzE0MF91SXpYanFU/bER2cGI0ODBWdUhF/VlZFRVh0cGpFZVh2/UC5qcGc',
    //   name: 'HongKong',
    //   description: 'Beautiful Skyscrappers',
    //   price: '\$1500',
    //   isAsset: false,
    // ),
    Destination(
      imageUrl: 'assets/images/iceland/Fiji.png',
      name: 'Fiji',
      description: 'Beautiful Skyscrappers',
      price: '\$1700',
      isAsset: true,
    ),
    // Destination(
    //   imageUrl:
    //       'https://media.gettyimages.com/id/1267692130/photo/zurich-old-town-by-the-limmat-river-on-a-sunny-summer-day-in-switzerland-largest-city.jpg?s=612x612&w=0&k=20&c=QRAaFEzYk7o3QEw1590MLmZI6Ufijjh7WEWRpHwDnww=',
    //   name: 'Switzerland',
    //   description: 'Beautiful country.',
    //   price: '\$1500',
    //   isAsset: false,
    // ),
    Destination(
      imageUrl: 'assets/images/iceland/maldives.webp',
      name: 'Maldives',
      description: 'A tropical paradise with stunning beaches.',
      price: '\$1200',
      isAsset: true,
    ),
    Destination(
      imageUrl: 'assets/images/country/nepal.png',
      name: 'Nepal',
      description: 'Country of the Gods with vibrant culture.',
      price: '\$900',
      isAsset: true,
    ),
    Destination(
      imageUrl: 'assets/images/lake/tilicho.webp',
      name: 'Tilicho Lake',
      description: 'Highest Lake in the World Located in Nepal.',
      price: '\$1200',
      isAsset: true,
    ),
    Destination(
      imageUrl: 'assets/images/city/Tokyo.png',
      name: 'Tokyo',
      description: 'Dazzling skyscrapers instead of lush rainforests.',
      price: '\$1250',
      isAsset: true,
    ),
    Destination(
      imageUrl: 'assets/images/iceland/maldives.webp',
      name: 'Maldives',
      description: 'Tropical paradise',
      price: '\$1500',
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
