import 'package:hero_anim/imports.dart';
class DetailPage extends StatelessWidget {
  final Destination destination;
  final String? categoryName;
  final String? itemName;

  const DetailPage({
    super.key,
    required this.destination,
    this.categoryName,
    this.itemName,
  });

  @override
  Widget build(BuildContext context) {
    // Helper widget to build the favorite icon, encapsulating the original logic
    Widget buildFavoriteButton() {
      if (categoryName != null && itemName != null) {
        return Consumer<CategoryProvider>(
          builder: (context, provider, _) {
            return IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  destination.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  key: ValueKey<bool>(destination.isFavorite),
                  color: destination.isFavorite ? Colors.red : Colors.grey,
                  size:
                      28, // Adjusted size to fit well in the circular container
                ),
              ),
              onPressed: () {
                provider.toggleFavorite(categoryName!, itemName!);
              },
            );
          },
        );
      } else {
        return Consumer<DestinationProvider>(
          builder: (context, provider, _) {
            return IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  destination.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  key: ValueKey<bool>(destination.isFavorite),
                  color: destination.isFavorite ? Colors.red : Colors.grey,
                  size:
                      28, // Adjusted size to fit well in the circular container
                ),
              ),
              onPressed: () {
                provider.toggleFavorite(destination);
              },
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: MyAppBar(
        title: destination.name,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'destination_hero_${destination.imageUrl}',
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(20.0), 
                child: Image.asset(
                  destination.imageUrl,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          destination.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Price: ${destination.price}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      // Favorite icon was here, now moved to bottom navigation bar
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(destination.description),
                ),
              ],
            ),

            const SizedBox(height: 80)
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors
            .white, // Background color matching the image's bottom bar area
        elevation: 0, // Image suggests minimal or no shadow for the bar itself
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(
                    10), // Padding inside the circle, around the icon
                decoration: BoxDecoration(
                  color: Colors
                      .grey[200], // Light grey background for the icon button
                  shape: BoxShape.circle,
                ),
                child:
                    buildFavoriteButton(), // Use the helper to build the favorite button
              ),
              const SizedBox(
                  width: 16), // Spacing between favorite icon and book button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Book now pressed! (Not implemented)')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Button color from image
                    foregroundColor: Colors.white, // Text color for the button
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30.0), // Rounded corners for the button
                    ),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Book now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:hero_anim/imports.dart';

// class DetailPage extends StatelessWidget {
//   final Destination destination;
//   final String? categoryName;
//   final String? itemName;

//   const DetailPage({
//     super.key,
//     required this.destination,
//     this.categoryName,
//     this.itemName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(
//         // backgroundColor: Colors.transparent,
//         title: destination.name,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // image display
//             Hero(
//               tag: 'destination_hero_${destination.imageUrl}',
//                 child: Image.asset(
//                   destination.imageUrl,
//                   height: 250,
//                   fit: BoxFit.cover,
//                 )),
//             const SizedBox(height: 16),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       destination.name,
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   if (categoryName != null && itemName != null)
//                     Consumer<CategoryProvider>(
//                       builder: (context, provider, _) {
//                         return IconButton(
//                           padding: EdgeInsets.zero,
//                           constraints: const BoxConstraints(),
//                           icon: AnimatedSwitcher(
//                             duration: const Duration(milliseconds: 300),
//                             transitionBuilder: (child, animation) =>
//                               ScaleTransition(
//                               scale: animation,
//                               child: child,
//                             ),
//                             child: Icon(
//                               destination.isFavorite
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               key: ValueKey<bool>(destination.isFavorite),
//                               color: destination.isFavorite
//                                   ? Colors.red
//                                   : Colors.grey,
//                               size: 32,
//                             ),
//                           ),
//                           onPressed: () {
//                             provider.toggleFavorite(categoryName!, itemName!);
//                           },
//                         );
//                       },
//                     )
//                   else
//                     Consumer<DestinationProvider>(
//                       builder: (context, provider, _) {
//                         return IconButton(
//                           padding: EdgeInsets.zero,
//                           constraints: const BoxConstraints(),
//                           icon: AnimatedSwitcher(
//                             duration: const Duration(milliseconds: 300),
//                             transitionBuilder: (child, animation) =>
//                                 ScaleTransition(
//                               scale: animation,
//                               child: child,
//                             ),
//                             child: Icon(
//                               destination.isFavorite
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               key: ValueKey<bool>(destination.isFavorite),
//                               color: destination.isFavorite
//                                   ? Colors.red
//                                   : Colors.grey,
//                               size: 32,
//                             ),
//                           ),
//                           onPressed: () {
//                             provider.toggleFavorite(destination);
//                           },
//                         );
//                       },
//                     ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text(destination.description),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 'Price: ${destination.price}',
//                 style: const TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
