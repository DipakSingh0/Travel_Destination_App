// features/favorites/widgets/favorite_icon_widget.dart
import 'package:flutter/material.dart';
import 'package:hero_anim/features/home/model/destination_model.dart';
import 'package:hero_anim/features/favorites/provider/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoriteIconWidget extends StatelessWidget {
  final Destination destination;
  final double size;

  const FavoriteIconWidget({
    super.key,
    required this.destination,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.isFavorite(destination);

    return GestureDetector(
      onTap: () => favoritesProvider.toggleFavorite(destination),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          key: ValueKey<bool>(isFavorite),
          color: isFavorite ? Colors.red : Colors.grey,
          size: size,
        ),
      ),
    );
  }
}

// // Create a new file favorite_icon_widget.dart
// import 'package:flutter/material.dart';
// import 'package:hero_anim/features/home/model/destination_model.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class FavoriteIconWidget extends StatefulWidget {
//   final Destination destination;
//   final double size;

//   const FavoriteIconWidget({
//     super.key,
//     required this.destination,
//     this.size = 24.0,
//   });

//   @override
//   State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
// }

// class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _toggleFavorite,
//       child: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 300),
//         transitionBuilder: (child, animation) => ScaleTransition(
//           scale: animation,
//           child: child,
//         ),
//         child: Icon(
//           widget.destination.isFavorite
//               ? Icons.favorite
//               : Icons.favorite_border,
//           key: ValueKey<bool>(widget.destination.isFavorite),
//           color: widget.destination.isFavorite ? Colors.red : Colors.grey,
//           size: widget.size,
//         ),
//       ),
//     );
//   }

//   void _toggleFavorite() {
//     final box = Hive.box<Destination>('favorites');
//     final key = box.keys.firstWhere(
//       (k) =>
//           (box.get(k) as Destination).imageUrl == widget.destination.imageUrl,
//       orElse: () => null,
//     );

//     if (key != null) {
//       box.delete(key);
//     } else {
//       box.add(widget.destination);
//     }
//   }
// }
