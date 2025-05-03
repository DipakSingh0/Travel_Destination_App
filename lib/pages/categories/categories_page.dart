// pages/categories_page.dart
import 'package:flutter/material.dart';
import 'package:hero_anim/model/destination_model.dart';
import 'package:hero_anim/pages/categories/categories_expansion_tile.dart';
import 'package:hero_anim/pages/detail_page.dart';
import 'package:hero_anim/provider/categories_provider.dart';
import 'package:provider/provider.dart';
import 'package:hero_anim/widget/my_appbar.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  void _navigateToDetail(BuildContext context, String category, String item) {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final categoryItem = categoryProvider.getItem(category, item);

    if (categoryItem != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailPage(
            destination: Destination(
              imageUrl: categoryItem.imageUrl,
              name: categoryItem.name,
              description: categoryItem.description,
              price: categoryItem.price,
              isAsset: true,
              isFavorite: categoryItem.isFavorite,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Explore Categories'),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          return ListView.builder(
            itemCount: categoryProvider.categories.length,
            itemBuilder: (context, index) {
              final category = categoryProvider.categories[index];
              return CategoryExpansionTile(
                category: category,
                onItemTap: (category, item) =>
                    _navigateToDetail(context, category, item),
              );
            },
          );
        },
      ),
    );
  }
}

// // pages/categories_page.dart
// import 'package:flutter/material.dart';
// import 'package:hero_anim/pages/categories/categories_expansion_tile.dart';
// import 'package:hero_anim/pages/categories/list_iem_widget.dart';
// import 'package:hero_anim/provider/categories_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:hero_anim/widget/my_appbar.dart';

// class CategoriesPage extends StatelessWidget {
//   const CategoriesPage({super.key});
  

//   void _showSubOptions(BuildContext context, String category, String item) {
//     Provider.of<CategoryProvider>(context, listen: false);

//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'More $item options',
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 return ListItem(
//                   title: '$item Option ${index + 1}',
//                   onTap: () {
//                     Navigator.pop(context);
//                     // Example: Add new item to category
//                     // categoryProvider.addItem(category, 'New $item Option ${index + 1}');
//                   },
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(title: 'Explore Categories'),
      
//       body: Consumer<CategoryProvider>(
//         builder: (context, categoryProvider, child) {
//           return ListView.builder(
//             itemCount: categoryProvider.categories.length,
//             itemBuilder: (context, index) {
//               final category = categoryProvider.categories[index];
//               return CategoryExpansionTile(
//                 category: category,
//                 onItemTap: (category, item) =>
//                     _showSubOptions(context, category, item),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
