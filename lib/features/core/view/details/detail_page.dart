import 'package:hero_anim/features/core/view/details/widget/detail_header.dart';
import 'package:hero_anim/features/core/view/details/widget/detail_info_section.dart';
import 'package:hero_anim/features/core/view/details/widget/details_action.dart';
import 'package:hero_anim/imports.dart';

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
          DetailHeader(
            imageUrl: widget.destination.imageUrl,
            heroTag: 'destination_hero_${widget.destination.imageUrl}',
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
//---------------info section ---------//
                  const SizedBox(height: 24,),
                  DetailInfoSection(
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
      bottomNavigationBar: DetailActions(
        destination: widget.destination,
        categoryName: widget.categoryName,
        itemName: widget.itemName, 
        amount: 20,
        // amount:  widget.price * _peopleCount,
      ),
    );
  }
}
