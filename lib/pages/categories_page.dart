import 'package:flutter/material.dart';
import 'package:hero_anim/widget/my_appbar.dart';

class CategoriesPage extends StatelessWidget {
  final Map<String, List<String>> categories = {
    'Mountains': ['Everest', 'Kilimanjaro', 'Denali', 'Matterhorn', 'Fuji'],
    'Lakes': [
      'Lake Superior',
      'Lake Baikal',
      'Caspian Sea',
      'Lake Victoria',
      'Crater Lake'
    ],
    'Cities': ['Paris', 'Tokyo', 'New York', 'Rome', 'Sydney'],
    'Forests': [
      'Amazon Rainforest',
      'Black Forest',
      'Redwood National Park',
      'Białowieża Forest',
      'Daintree Rainforest'
    ],
    'Rivers': ['Nile', 'Amazon', 'Yangtze', 'Mississippi', 'Danube'],
  };

   CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      MyAppBar(title: 'Explore Categories'),
      // AppBar(
      //   title: const Text('Explore Categories'),
      // ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories.keys.elementAt(index);
          return ExpansionTile(
            title: Text(
              category,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: categories[category]!
                .map((item) => ListTile(
                      title: Text(item),
                      onTap: () {
                        // Navigate to details page or show more options
                        _showSubOptions(context, category, item);
                      },
                    ))
                .toList(),
          );
        },
      ),
    );
  }

  void _showSubOptions(BuildContext context, String category, String item) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'More $item options',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('$item Option ${index + 1}'),
                  onTap: () {
                    Navigator.pop(context);
                    // Handle option selection
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
