import 'package:hero_anim/imports.dart';
import 'package:hero_anim/features/core/view/map_screen1.dart';

class DetailInfoSection extends StatelessWidget {
  final Destination destination;
  final int peopleCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const DetailInfoSection({
    super.key,
    required this.destination,
    required this.peopleCount,
    required this.onIncrement,
    required this.onDecrement,
  });

  void openMapScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          destination: destination,
          mapTitle: destination.name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  destination.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(width: 8,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'Price: ${destination.price}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          //------ratings and see in map row------ //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Rating : ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    destination.rating.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => openMapScreen(context),
                child: Row(
                  children: [
                    Text(
                      'See in Map',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Date and People Counter Row
          Row(
            children: [
              // Date section
              const Row(
                children: [
                  Icon(Icons.calendar_today, size: 20),
                  SizedBox(width: 8),
                  Text("Date",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                ],
              ),

              const Spacer(),

              // People counter
              Row(
                children: [
                  const Text('People',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 2),
                  IconButton(
                    icon: const Icon(Icons.remove, size: 18),
                    onPressed: onDecrement,
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(
                    width: 5,
                    child: Text(
                      "$peopleCount",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: onIncrement,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// // Combined Info Section Widget
// import 'package:hero_anim/imports.dart';

// class DetailInfoSection extends StatelessWidget {
//   final Destination destination;
//   final int peopleCount;
//   final VoidCallback onIncrement;
//   final VoidCallback onDecrement;

//   const DetailInfoSection({
//     super.key,
//     required this.destination,
//     required this.peopleCount,
//     required this.onIncrement,
//     required this.onDecrement,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Title and Price Row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Text(
//                   destination.name,
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 // const SizedBox(width: 8,),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 2),
//                 child: Text(
//                   'Price: ${destination.price}',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 10),

//           //------ratings and see in map row------ //
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     'Rating : ',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                   ),
//                   Text(
//                     destination.rating.toString(),
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   Icon(
//                     Icons.star,
//                     color: Colors.yellow,
//                     size: 20,
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'See in Map',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   Icon(
//                     Icons.location_on,
//                     color: Colors.blue,
//                     size: 22,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),

//           // Date and People Counter Row
//           Row(
//             children: [
//               // Date section
//               const Row(
//                 children: [
//                   Icon(Icons.calendar_today, size: 20),
//                   SizedBox(width: 8),
//                   Text("Date",
//                       style:
//                           TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
//                 ],
//               ),

//               const Spacer(),

//               // People counter
//               Row(
//                 children: [
//                   const Text('People',
//                       style:
//                           TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
//                   const SizedBox(width: 2),
//                   IconButton(
//                     icon: const Icon(Icons.remove, size: 18),
//                     onPressed: onDecrement,
//                     padding: EdgeInsets.zero,
//                   ),
//                   SizedBox(
//                     width: 5,
//                     child: Text(
//                       "$peopleCount",
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.add, size: 18),
//                     onPressed: onIncrement,
//                     padding: EdgeInsets.zero,
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           const SizedBox(height: 8),
//         ],
//       ),
//     );
//   }
// }
