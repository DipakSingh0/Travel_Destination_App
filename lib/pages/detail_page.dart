import 'package:flutter/material.dart';
import 'package:hero_anim/model/destination_model.dart';
import 'package:hero_anim/widget/my_appbar.dart';

class DetailPage extends StatelessWidget {
  final Destination destination;

  const DetailPage({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: destination.name ,),
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
