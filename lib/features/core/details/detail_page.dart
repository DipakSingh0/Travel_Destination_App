import 'package:hero_anim/common/widgets/primary_button.dart';
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
//--------people counter button ---------//
  int _peopleCount = 0; 

  void _increment() {
    setState(() {
      _peopleCount++;
    });
  }

  void _decrement() {
    setState(() {
      if (_peopleCount > 1) {
        _peopleCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Helper widget to build the favorite icon, encapsulating the original logic
    Widget buildFavoriteButton() {
      if (widget.categoryName != null && widget.itemName != null) {
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
                  widget.destination.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  key: ValueKey<bool>(widget.destination.isFavorite),
                  color: widget.destination.isFavorite ? Colors.red : Colors.grey,
                  size:
                      28, // Adjusted size to fit well in the circular container
                ),
              ),
              onPressed: () {
                provider.toggleFavorite(widget.categoryName!, widget.itemName!);
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
                  widget.destination.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  key: ValueKey<bool>(widget.destination.isFavorite),
                  color: widget.destination.isFavorite ? Colors.red : Colors.grey,
                  size:
                      28, 
                ),
              ),
              onPressed: () {
                provider.toggleFavorite(widget.destination);
              },
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: null,
      // MyAppBar(
      //   title: widget.destination.name,
      // ),
      body:  Column(
        children: [
         Stack(
            children: [
              Hero(
                tag: 'destination_hero_${widget.destination.imageUrl}',
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  child: Image.asset(
                    widget.destination.imageUrl,
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
                    color: const Color.fromARGB(
                        128, 0, 0, 0),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

        
      //------------------destination name , price ,description ----------------------//
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            widget.destination.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Price: ${widget.destination.price}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                    //------------------- Date section with icon-----------------//
                      Row(
                        children: [
                          const SizedBox(width: 14),
                          Icon(Icons.calendar_today, size: 20),
                          SizedBox(width: 8),
                          Text("Date"),
                        ],
                      ),
                    
                      Spacer(),
                    
                      //------------------- People counter with increment/decrement-----------------//
                    Row(
                        children: [
                          Text('People', style: TextStyle(fontSize: 14,),),
                          const SizedBox(width: 8),
                          
                          IconButton(
                            icon: const Icon(Icons.remove, size: 16),
                            onPressed: _decrement,
                            padding: EdgeInsets.zero,
                            // constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 8),
                          Text("$_peopleCount"), 
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.add, size: 16),
                            onPressed: _increment,
                            padding: EdgeInsets.zero,
                            // constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 18),
                    
                        ],
                      ),
                    ],
                  ),
                    //------------------Deatails pagargph ------------//
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(widget.destination.description),
                  ),
                ],
              ),
            ),
          ),
      
          // const SizedBox(height: 80)
        ],
      ),


//-------------- favorite button and Book Button -------------//
      bottomNavigationBar: BottomAppBar(
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
                child: buildFavoriteButton(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PrimaryButton(
                  text: 'Book now',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Book now pressed! (Not implemented)')),
                    );
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
      ),
    );
  }
}
