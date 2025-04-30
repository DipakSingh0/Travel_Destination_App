import 'package:flutter/material.dart';
import 'package:hero_anim/pages/detail_page.dart';
import 'package:hero_anim/provider/destination_provider.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites =
        Provider.of<DestinationProvider>(context).favoriteDestinations;

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final destination = favorites[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(10),

            title: Text(destination.name),
            subtitle: Text(destination.description),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: destination.isAsset
                  ? Image.asset(destination.imageUrl,
                      width: 80, height: 80, fit: BoxFit.cover)
                  : Image.network(destination.imageUrl,
                      width: 80, height: 80, fit: BoxFit.cover),
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
      ),
    );
  }
}
