import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      appBar:
       MyAppBar(
        title: "Travel Destination",
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

      body: Padding(
  padding: const EdgeInsets.all(8.0),
  child: MasonryGridView.builder(
    gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    itemCount: destinations.length,
    itemBuilder: (context, index) {
      final destination = destinations[index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CustomPageRoute(
              builder: (_) => DetailPage(destination: destination),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'destination__hero_${destination.imageUrl}',
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: destination.isAsset
                      ? Image.asset(destination.imageUrl,
                          fit: BoxFit.cover)
                      : Image.network(destination.imageUrl,
                          fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  destination.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  destination.price,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    },
  ),
));
  }}