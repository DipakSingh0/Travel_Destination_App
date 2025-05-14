// ignore_for_file: use_build_context_synchronously

import 'package:hero_anim/features/core/services/stripe_services.dart';
import 'package:hero_anim/imports.dart';

class DetailActions extends StatelessWidget {
  final Destination destination;
  final String? categoryName;
  final String? itemName;
  final double amount; 

  const DetailActions({
    super.key,
    required this.destination,
    this.categoryName,
    this.itemName,
    required this.amount, 
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Consumer<FavoritesProvider>(
                builder: (context, favoritesProvider, child) {
                  return FavoriteIconWidget(
                    destination: destination,
                    size: 28,
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: PrimaryButton(
                text: 'Book now',
                onTap: () async {
                  try {
                    await StripeService.instance.makePayment(
                      amount: amount,
                      currency: 'USD', // Or your currency
                      description: 'Booking for ${destination.name}',
                    );

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Payment successful! Booking confirmed.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } catch (e) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Payment failed: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                textColor: Colors.white,
                color: Colors.blue,
                borderRadius: 30.0,
                fontSize: 18.0,
                height: 45.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:hero_anim/imports.dart';

// class DetailActions extends StatelessWidget {
//   final Destination destination;
//   final String? categoryName;
//   final String? itemName;

//   const DetailActions({super.key, 
//     required this.destination,
//     this.categoryName,
//     this.itemName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       color: Colors.transparent,
//       elevation: 0,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//         child: Row(
//           children: [
//               Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 shape: BoxShape.circle,
//               ),
//               child: Consumer<FavoritesProvider>(
//                 builder: (context, favoritesProvider, child) {
//                   return FavoriteIconWidget(
//                     destination: destination,
//                     size: 28,
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: PrimaryButton(
//                 text: 'Book now',
//                 onTap: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Book pressed!')),
//                   );
//                 },
//                 textColor: Colors.white,
//                 color: Colors.blue,
//                 borderRadius: 30.0,
//                 fontSize: 18.0,
//                 height: 45.0,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }