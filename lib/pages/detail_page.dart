import 'package:flutter/material.dart';
import 'package:hero_anim/model/destination_model.dart';
import 'package:hero_anim/widget/my_appbar.dart';
import 'package:provider/provider.dart';
import 'package:hero_anim/provider/destination_provider.dart';

class DetailPage extends StatelessWidget {
  final Destination destination;

  const DetailPage({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: destination.name,
        actions: [
          Consumer<DestinationProvider>(
            builder: (context, provider, _) {
              return IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                  child: Icon(
                    destination.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    key: ValueKey<bool>(destination.isFavorite),
                    color: destination.isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
                onPressed: () {
                  provider.toggleFavorite(destination);
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: destination.imageUrl,
            child: destination.isAsset
                ? Image.asset(destination.imageUrl,
                    height: 250, fit: BoxFit.cover)
                : Image.network(destination.imageUrl,
                    height: 250, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(destination.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(destination.description),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Price: ${destination.price}',
                style: const TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}