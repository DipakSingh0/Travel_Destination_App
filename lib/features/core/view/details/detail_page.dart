import 'package:travel_ease/features/core/services/stripe_services.dart';
import 'package:travel_ease/features/core/view/map_screen1.dart';
import 'package:travel_ease/imports.dart';

class DetailPage extends StatefulWidget {
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
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _peopleCount = 1;

  void _increment() => setState(() => _peopleCount++);
  void _decrement() => setState(() => _peopleCount > 1 ? _peopleCount-- : null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          //---------- Header with Hero image and back button
          _DetailHeader(
            imageUrl: widget.destination.imageUrl,
            heroTag: 'destination_hero_${widget.destination.imageUrl}',
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
//---------------info section ---------//
                  const SizedBox(
                    height: 24,
                  ),
                  _DetailInfoSection(
                    destination: widget.destination,
                    peopleCount: _peopleCount,
                    onIncrement: _increment,
                    onDecrement: _decrement,
                  ),

                  // Description
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(widget.destination.description),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Bottom action bar
      bottomNavigationBar: _DetailActions(
        destination: widget.destination,
        categoryName: widget.categoryName,
        itemName: widget.itemName,
        amount: 20,
        // amount:  widget.price * _peopleCount,
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const _DetailHeader({
    required this.imageUrl,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: heroTag,
          // tag: destination_hero_${destination.imageUrl},
          // tag: 'destination_hero_${destination.name}',
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Image.asset(
              imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(128, 0, 0, 0),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailInfoSection extends StatelessWidget {
  final Destination destination;
  final int peopleCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _DetailInfoSection({
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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

// ignore_for_file: use_build_context_synchronously
class _DetailActions extends StatelessWidget {
  final Destination destination;
  final String? categoryName;
  final String? itemName;
  final double amount;

  const _DetailActions({
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                // color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Consumer<FavoritesProvider>(
                builder: (context, favoritesProvider, child) {
                  return FavoriteIconWidget(
                    destination: destination,
                    size: 35,
                  );
                },
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: PrimaryButton(
                text: 'Book now',
                onTap: () async {
                  try {
                    //-----calling makePayment with destination object
                    await StripeService.instance.makePayment(
                      // amount: 100,
                      currency: 'USD',
                      destination: destination,
                      // description: 'Booking for ${destination.name}',
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
                fontSize: 20.0,
                height: 100.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
