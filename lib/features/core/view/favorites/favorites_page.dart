import 'package:hero_anim/imports.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Favorites"),
      drawer: DrawerWidget(
        userName: "Robert Downey Jr.",
        userEmail: "rdj@marvel.com",
        profileImageUrl: "assets/images/profile.jpg",
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, provider, _) {
          if (provider.favorites.isEmpty) {
            return const Center(
              child: Text("No favorites yet!"),
            );
          }

          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              final destination = provider.favorites[index];
              return ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                   tag: 'destination_hero_${destination.imageUrl}',
                    child: Image.asset(
                            destination.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                  )
                ),
                title: Text(destination.name),
                subtitle: Text(destination.description, maxLines: 2),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(destination.price),
                    const SizedBox(width: 8),
                    FavoriteIconWidget(
                      destination: destination,
                      size: 28,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(destination: destination),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: Consumer<FavoritesProvider>(
        builder: (context, provider, _) {
          return provider.favorites.isNotEmpty
              ? FloatingActionButton(
                  // onPressed: () => _confirmClearAll(context, provider),
                  onPressed: () async {
                    await _confirmClearAll(context , provider);
                  },
                  tooltip: 'Clear All',
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                )
              : const SizedBox();
        },
      ),
    );
  }

  Future<void> _confirmClearAll(BuildContext context, FavoritesProvider provider)async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Favorites?'),
        content: const Text('This will remove all your favorite destinations.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              provider.clearAllFavorites();
              Navigator.pop(context);
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
