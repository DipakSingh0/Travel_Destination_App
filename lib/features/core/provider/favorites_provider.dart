// features/favorites/provider/favorites_provider.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hero_anim/features/core/model/destination_model.dart';

class FavoritesProvider with ChangeNotifier {
  final Box<Destination> _favoritesBox;

  FavoritesProvider(this._favoritesBox);

  List<Destination> get favorites => _favoritesBox.values.toList();

  bool isFavorite(Destination destination) {
    return _favoritesBox.values.any(
      (d) => d.imageUrl == destination.imageUrl,
    );
  }

  void toggleFavorite(Destination destination) {
    if (isFavorite(destination)) {
      _removeFavorite(destination);
    } else {
      _addFavorite(destination);
    }
    notifyListeners();
  }

  void _addFavorite(Destination destination) {
    if (!isFavorite(destination)) {
      _favoritesBox.add(destination.copyWith(isFavorite: true));
    }
  }

  void _removeFavorite(Destination destination) {
    final key = _favoritesBox.keys.firstWhere(
      (k) =>
          (_favoritesBox.get(k) as Destination).imageUrl ==
          destination.imageUrl,
      orElse: () => null,
    );
    if (key != null) {
      _favoritesBox.delete(key);
    }
  }

  Future<void> clearAllFavorites() async {
    await _favoritesBox.clear();
    notifyListeners();
  }
}
