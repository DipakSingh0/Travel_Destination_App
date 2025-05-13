// import 'package:hero_anim/imports.dart';

// class DestinationGridView extends StatelessWidget {
//   final List<Destination> destinations;
//   final int crossAxisCount;
//   final EdgeInsets padding;
//   final EdgeInsets margin;
//   final double elevation;
//   final BorderRadius borderRadius;

//   const DestinationGridView({
//     super.key,
//     required this.destinations,
//     this.crossAxisCount = 2,
//     this.padding = const EdgeInsets.all(8.0),
//     this.margin = const EdgeInsets.all(8),
//     this.elevation = 4,
//     this.borderRadius = const BorderRadius.vertical(top: Radius.circular(16)),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding,
//       child: MasonryGridView.builder(
//         gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxisCount,
//         ),
//         itemCount: destinations.length,
//         itemBuilder: (context, index) {
//           final destination = destinations[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 CustomPageRoute(
//                   builder: (_) => DetailPage(destination: destination),
//                 ),
//               );
//             },
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: elevation,
//               margin: margin,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Hero(
//                     tag: 'destination_hero_${destination.imageUrl}',
//                     child: ClipRRect(
//                       borderRadius: borderRadius,
//                       child:
//                           Image.asset(
//                               destination.imageUrl,
//                               fit: BoxFit.cover,
//                             )

//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       destination.name,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       destination.price,
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                   ),
//                   // const SizedBox(height: 8),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:hero_anim/features/core/favorites/widgets/favorite_icon_widget.dart';

import 'package:hero_anim/imports.dart';

class DestinationGridView extends StatelessWidget {
  final List<Destination> destinations;
  final int crossAxisCount;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double elevation;
  // final BorderRadius borderRadius;

  const DestinationGridView({
    super.key,
    required this.destinations,
    this.crossAxisCount = 2,
    this.padding = const EdgeInsets.all(8.0),
    this.margin = const EdgeInsets.all(8),
    this.elevation = 4,
    // this.borderRadius = const BorderRadius.vertical(top: Radius.circular(16)),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: MasonryGridView.builder(
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
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
              elevation: elevation,
              margin: margin,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Hero(
                        tag: 'destination_hero_${destination.imageUrl}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16)), 
                          child: Image.asset(
                            destination.imageUrl,
                            // height: 250,
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    ],
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            destination.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            destination.price,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    // top: 8,
                    bottom: 20,
                    right: 12,
                    child: FavoriteIconWidget(
                      destination: destination,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
