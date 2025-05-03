// features/favorites/pages/favorite_page.dart
import 'package:hero_anim/features/favorites/widgets/favorite_icon_widget.dart';
import 'package:hero_anim/features/favorites/provider/favorites_provider.dart';
import 'package:hero_anim/imports.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Favorites"),
      drawer: DrawerWidget(
        userName: "Jane Smith",
        userEmail: "jane@example.com",
        profileImageUrl: "images/profile.jpg",
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
                  child: destination.isAsset
                      ? Image.asset(
                          destination.imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          destination.imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                ),
                title: Text(destination.name),
                subtitle: Text(destination.description),
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
                  onPressed: () => _confirmClearAll(context, provider),
                  tooltip: 'Clear All',
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                )
              : const SizedBox();
        },
      ),
    );
  }

  void _confirmClearAll(BuildContext context, FavoritesProvider provider) {
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

// import 'package:hero_anim/imports.dart';

// class FavoritePage extends StatelessWidget {
//   const FavoritePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:
//       MyAppBar(title: "Favorites"), 
      
//       drawer: DrawerWidget(
//         userName: "Jane Smith",
//         userEmail: "jane@example.com",
//         profileImageUrl: "images/profile.jpg",
//       ),
//       // AppBar(title: const Text("Favorites") , centerTitle: true,),
//       body: ValueListenableBuilder<Box<Destination>>(
//         valueListenable: Hive.box<Destination>('favorites').listenable(),
//         builder: (context, box, _) {
//           final favorites = box.values.toList();

//           if (favorites.isEmpty) {
//             return const Center(
//               child: Text("No favorites yet!"),
//             );
//           }

//           return ListView.builder(
//             itemCount: favorites.length,
//             itemBuilder: (context, index) {
//               final destination = favorites[index];
//               return ListTile(
//                 contentPadding: const EdgeInsets.all(10),
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: destination.isAsset
//                       ? Image.asset(
//                           destination.imageUrl,
//                           width: 80,
//                           height: 80,
//                           fit: BoxFit.cover,
//                         )
//                       : Image.network(
//                           destination.imageUrl,
//                           width: 80,
//                           height: 80,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//                 title: Row(
//                   children: [
//                     Expanded(
//                       child: Text(destination.name),
//                     ),
//                     // FavoriteIconWidget(
//                     //   destination: destination,
//                     //   size: 28,
//                     // ),
//                   ],
//                 ),
//                 subtitle: Text(destination.description),
//                 trailing: Text(destination.price),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DetailPage(destination: destination),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
