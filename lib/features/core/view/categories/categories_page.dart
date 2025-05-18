// pages/categories_page.dart
import 'package:flutter/material.dart';
import 'package:hero_anim/common/widgets/drawer_widget.dart';
import 'package:hero_anim/common/widgets/my_appbar.dart';
import 'package:hero_anim/features/core/model/destination_model.dart';
import 'package:hero_anim/features/core/view/categories/widgets/categories_expansion_tile.dart';
import 'package:hero_anim/features/core/view/details/detail_page.dart';
import 'package:hero_anim/features/core/provider/categories_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  void _navigateToDetail(BuildContext context, String category, String item) {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final categoryItem = categoryProvider.getItem(category, item);

    if (categoryItem != null) {
      final destination = Destination(
        imageUrl: categoryItem.imageUrl,
        name: categoryItem.name,
        description: categoryItem.description,
        price: categoryItem.price,
        isAsset: true,
        isFavorite: categoryItem.isFavorite,
      );
      
      context.push(
        Uri(
          path: '/details',
          queryParameters: {
            'category': category,
            'item': item,
          },
        ).toString(),
        extra: destination,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Explore Categories"),
      drawer: DrawerWidget(
        userName: "Robert Downey Jr.",
        userEmail: "rdj@marvel.com",
        profileImageUrl: "assets/images/profile.jpg",
      ),
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
