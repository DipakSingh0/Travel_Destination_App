import 'package:hero_anim/common/widgets/primary_button.dart';
import 'package:hero_anim/imports.dart';

class DetailActions extends StatelessWidget {
  final Destination destination;
  final String? categoryName;
  final String? itemName;

  const DetailActions({super.key, 
    required this.destination,
    this.categoryName,
    this.itemName,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: _buildFavoriteButton(context),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: PrimaryButton(
                text: 'Book now',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Book pressed!')),
                  );
                },
                textColor: Colors.white,
                color: Colors.blue,
                borderRadius: 30.0,
                fontSize: 18.0,
                height: 45.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    if (categoryName != null && itemName != null) {
      return Consumer<CategoryProvider>(
        builder: (context, provider, _) {
          return IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                destination.isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey<bool>(destination.isFavorite),
                color: destination.isFavorite ? Colors.red : Colors.grey,
                size: 28,
              ),
            ),
            onPressed: () => provider.toggleFavorite(categoryName!, itemName!),
          );
        },
      );
    } else {
      return Consumer<DestinationProvider>(
        builder: (context, provider, _) {
          return IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                destination.isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey<bool>(destination.isFavorite),
                color: destination.isFavorite ? Colors.red : Colors.grey,
                size: 28,
              ),
            ),
            onPressed: () => provider.toggleFavorite(destination),
          );
        },
      );
    }
  }
}
