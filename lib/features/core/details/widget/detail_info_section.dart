// Combined Info Section Widget
import 'package:hero_anim/imports.dart';

class DetailInfoSection extends StatelessWidget {
  final Destination destination;
  final int peopleCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const DetailInfoSection({super.key, 
    required this.destination,
    required this.peopleCount,
    required this.onIncrement,
    required this.onDecrement,
  });

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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Price: ${destination.price}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Date and People Counter Row
          Row(
            children: [
              // Date section
              const Row(
                children: [
                  Icon(Icons.calendar_today, size: 20),
                  SizedBox(width: 8),
                  Text("Date"),
                ],
              ),

              const Spacer(),

              // People counter
              Row(
                children: [
                  const Text('People', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.remove, size: 16),
                    onPressed: onDecrement,
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(
                    width: 24,
                    child: Text(
                      "$peopleCount",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 16),
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
