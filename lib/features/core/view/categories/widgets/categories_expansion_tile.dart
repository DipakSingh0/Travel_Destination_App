// pages/categories/categories_expansion_tile.dart
import 'package:flutter/material.dart';
import 'package:hero_anim/features/core/model/category_model.dart';
import 'package:hero_anim/features/core/view/categories/widgets/list_item_widget.dart';

class CategoryExpansionTile extends StatelessWidget {
  final Category category;
  final Function(String category, String item)? onItemTap;

  const CategoryExpansionTile({
    super.key,
    required this.category,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        category.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: category.items.values.map((item) {
        return ListItem(
          title: item.name,
          subtitle: '${category.name} destination',
          imageUrl: item.imageUrl,
          heroTag: 'destination_hero_${item.imageUrl}',
          onTap: () => onItemTap?.call(category.name, item.name),
        );
      }).toList(),
    );
  }
}
