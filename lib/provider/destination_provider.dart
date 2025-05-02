import 'package:flutter/material.dart';
import 'package:hero_anim/model/destination_model.dart';
import 'package:hive/hive.dart';

class DestinationProvider with ChangeNotifier {
  final List<Destination> _destinations = [
    Destination(
      'images/Tokyo.png',
      'Tokyo',
      'Dazzling skyscrapers instead of lush rainforests.',
      '\$1250',
      true,
    ),
    Destination(
      'images/Tokyo.png',
      'Tokyo',
      'Beautiful Skyscrappers',
      '\$1500',
      true,
    ),
    Destination('images/maldives.webp', 'Maldives',
        'A tropical paradise with stunning beaches.', '\$1200', true),
    Destination('images/nepal.png', 'Nepal',
        'Country of the Gods with vibrant culture.', '\$900', true),
    Destination(
      'https://imgs.search.brave.com/2sk2J7cfOUGZgv9akDJIjakOfdmKEY3pjDdVE5qhYYY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAyLzE5LzgxLzMx/LzM2MF9GXzIxOTgx/MzE0MF91SXpYanFU/bER2cGI0ODBWdUhF/VlZFRVh0cGpFZVh2/UC5qcGc',
      'HongKong',
      'Beautiful Skyscrappers',
      '\$1500',
      false,
    ),
    Destination(
      'images/Fiji.png',
      'Fiji',
      'Beautiful Skyscrappers',
      '\$1700',
      true,
    ),
    Destination(
      'images/nepal.png',
      'Nepal',
      'Country of the Gods with vibrant culture.',
      '\$900',
      true,
    ),
    Destination(
      'images/newyork.webp',
      'Newyork',
      'Country of the Skyscrappers with Enterpreneurs.',
      '\$1600',
      true,
    ),
    Destination(
      'https://media.gettyimages.com/id/1267692130/photo/zurich-old-town-by-the-limmat-river-on-a-sunny-summer-day-in-switzerland-largest-city.jpg?s=612x612&w=0&k=20&c=QRAaFEzYk7o3QEw1590MLmZI6Ufijjh7WEWRpHwDnww=',
      'Switzerland',
      'Beautiful country.',
      '\$1500',
      false,
    ),
    Destination(
      'images/maldives.webp',
      'Maldives',
      'A tropical paradise with stunning beaches.',
      '\$1200',
      true,
    ),
    Destination(
      'images/nepal.png',
      'Nepal',
      'Country of the Gods with vibrant culture.',
      '\$900',
      true,
    ),
    Destination(
      'https://imgs.search.brave.com/f-MZRZwspem6aVCqOr18ZVpE-p02TuG1fEJ5bWu3r_w/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNjgz/MzIxNDMzL3Bob3Rv/L2hvbmcta29uZy1z/a3lsaW5lLWF0LXN1/bnJpc2UuanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPUJzcC1Q/ekwtWnJHeDIzdzJq/OWUwRl95ZlFLd3du/R0NiRWVwS01NVzQw/S0k9',
      'HongKong',
      'Beautiful Skyscrappers',
      '\$1500',
      false,
    ),
    Destination(
      'images/maldives.webp',
      'Maldives',
      'Tropical paradise',
      '\$1500',
      true,
    ),
  ];

  //using hive as persistance storage
  final Box<Destination> _favoritesBox = Hive.box<Destination>('favorites');

  List<Destination> get destinations => _destinations;

// adding favorites to list
  List<Destination> get favoriteDestinations {
    return _favoritesBox.values.toList();
  }

  void toggleFavorite(Destination destination) {
    destination.isFavorite = !destination.isFavorite;

    if (destination.isFavorite) {
      _addToFavorites(destination);
    } else {
      _removeFromFavorites(destination);
    }
    notifyListeners();
  }

//   List<Destination> get favoriteDestinations =>
//       _destinations.where((d) => d.isFavorite).toList();
// }

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
