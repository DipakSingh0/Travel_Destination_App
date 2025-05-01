import 'package:flutter/material.dart';
import 'package:hero_anim/pages/detail_page.dart';
import 'package:hero_anim/pages/favorites_page.dart';
import 'package:hero_anim/provider/destination_provider.dart';
import 'package:hero_anim/widget/custom_page_route.dart';
import 'package:hero_anim/widget/drawer_widget.dart';
import 'package:hero_anim/widget/my_appbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final destinations = Provider.of<DestinationProvider>(context).destinations;

    return Scaffold(
      appBar: MyAppBar(
        title: "Animation",
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritePage()),
              );
            },
          )
        ],
      ),
      // drawer: DrawerWidget(userName: userName, userEmail: userEmail, profileImageUrl: profileImageUrl),
     drawer: DrawerWidget(
        userName: "Jane Smith",
        userEmail: "jane@example.com",
        profileImageUrl: "images/profile.jpg",
      ),
      body: ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final destination = destinations[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: Hero(
              tag: 'destination__hero_${destination.imageUrl}',
              // tag: destination.imageUrl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: destination.isAsset
                    ? Image.asset(destination.imageUrl,
                        width: 80, height: 80, fit: BoxFit.cover)
                    : Image.network(destination.imageUrl,
                        width: 80, height: 80, fit: BoxFit.cover),
              ),
            ),
            title: Text(destination.name),
            subtitle: Text(destination.description),
            trailing: Text(destination.price),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => DetailPage(destination: destination),
              //   ),
              // );

               Navigator.push(
                context,
                CustomPageRoute(
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
