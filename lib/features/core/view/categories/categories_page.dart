import 'package:travel_ease/common/utils/imports.dart';

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
        rating: categoryItem.rating,
        latitude: categoryItem.latitude,
        longitude: categoryItem.longitude,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(
            destination: destination,
            categoryName: category,
            itemName: item,
          ),
        ),
      );
      
      // context.push(
      //   Uri(
      //     path: '/details',
      //     queryParameters: {
      //       'category': category,
      //       'item': item,
      //     },
      //   ).toString(),
      //   extra: destination,
      // );
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
              return _CategoryExpansionTile(
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


class _CategoryExpansionTile extends StatelessWidget {
  final Category category;
  final Function(String category, String item)? onItemTap;

  const _CategoryExpansionTile({
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
          //--------------
        //  trailing: Row(
        //               children: [
        //                 Text(category.rating.toString()),
        //                 Icon(Icons.star, color: Colors.yellow),
        //               ],
        //             ),
          imageUrl: item.imageUrl,
          heroTag: 'destination_hero_${item.imageUrl}',
          onTap: () => onItemTap?.call(category.name, item.name),
        );
      }).toList(),
    );
  }
}


class ListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final String? heroTag;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.heroTag,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: imageUrl != null
          ? Hero(
            // ------ using herotag or destination tiltle for animatio
              tag:  heroTag?? 'destination_hero_$title',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : null,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
