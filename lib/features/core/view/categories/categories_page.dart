import 'package:hero_anim/imports.dart';

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
