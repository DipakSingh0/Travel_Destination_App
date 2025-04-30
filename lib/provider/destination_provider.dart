import 'package:flutter/material.dart';
import 'package:hero_anim/model/destination_model.dart';

class DestinationProvider with ChangeNotifier {
  final List<Destination> _destinations = [
    Destination(
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
      'Maldives',
      'A tropical paradise with stunning beaches.',
      '\$1250',
      false,
    ),
    Destination(
      'https://imgs.search.brave.com/0DJ8BcdiG7jYG_jAQw9m7iaDmMqvi1ZUqsoeU3n9BgU/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by92aWN0b3JpYS1w/ZWFrLWhvbmcta29u/Zy0yMi1qdW5lLTIw/MTYtaG9uZy1rb25n/LWNpdHlfMzI4MTkx/LTgxLmpwZz9zZW10/PWFpc19oeWJyaWQm/dz03NDA',
      'HongKong',
      'Beautiful Skyscrappers',
      '\$1500',
      false,
    ),
    Destination(
      'images/maldives.webp', 
      'Maldives',
      'A tropical paradise with stunning beaches.',
      '\$1200', 
      true),
    Destination(
      'images/nepal.png', 
      'Nepal',
        'Country of the Gods with vibrant culture.',
         '\$900', 
         true),
    Destination(
      'images/newyork.webp', 
      'Newyork',
        'Country of the Skyscrappers with Enterpreneurs.', '\$1600', true),
    Destination(
      'https://media.gettyimages.com/id/1267692130/photo/zurich-old-town-by-the-limmat-river-on-a-sunny-summer-day-in-switzerland-largest-city.jpg?s=612x612&w=0&k=20&c=QRAaFEzYk7o3QEw1590MLmZI6Ufijjh7WEWRpHwDnww=', 
    'Switzerland', 
    'Beautiful country.',
        '\$1500', 
        false),
          Destination('images/maldives.webp', 'Maldives',
        'A tropical paradise with stunning beaches.', '\$1200', true),
    Destination('images/nepal.png', 'Nepal',
        'Country of the Gods with vibrant culture.', '\$900', true),
         Destination(
      'https://imgs.search.brave.com/0DJ8BcdiG7jYG_jAQw9m7iaDmMqvi1ZUqsoeU3n9BgU/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by92aWN0b3JpYS1w/ZWFrLWhvbmcta29u/Zy0yMi1qdW5lLTIw/MTYtaG9uZy1rb25n/LWNpdHlfMzI4MTkx/LTgxLmpwZz9zZW10/PWFpc19oeWJyaWQm/dz03NDA',
      'HongKong',
      'Beautiful Skyscrappers',
      '\$1500',
      false,
    ),
  ];

  List<Destination> get destinations => _destinations;

  
  void toggleFavorite(Destination destination) {
    destination.isFavorite = !destination.isFavorite;
    notifyListeners();
  }

  List<Destination> get favoriteDestinations =>
      _destinations.where((d) => d.isFavorite).toList();
}
