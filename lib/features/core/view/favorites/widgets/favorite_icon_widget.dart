import 'package:travel_ease/imports.dart';

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