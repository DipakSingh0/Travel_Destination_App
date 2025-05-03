import 'package:flutter/material.dart';
import 'package:hero_anim/animation/page_transition_animation.dart';
import 'package:hero_anim/pages/categories/categories_page.dart';
import 'package:hero_anim/pages/favorites_page.dart';
import 'package:hero_anim/pages/home/destination_grid_view.dart';
import 'package:hero_anim/pages/profile/profile_page.dart';
import 'package:hero_anim/provider/destination_provider.dart';
import 'package:hero_anim/widget/bottom_nav_bar.dart';
import 'package:hero_anim/widget/drawer_widget.dart';
import 'package:hero_anim/widget/my_appbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
   const CategoriesPage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? MyAppBar(
              title: "Travel Destination",
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransitionAnimation(
                          builder: (_) => const FavoritePage()),
                    );
                  },
                )
              ],
            )
          : null,
      drawer: _currentIndex == 0
          ? DrawerWidget(
              userName: "Jane Smith",
              userEmail: "jane@example.com",
              profileImageUrl: "images/profile.jpg",
            )
          : null,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 900),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(0.5, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutQuart,
          ));

          final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeIn,
            ),
          );

          return SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: _pages[_currentIndex],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final destinations = Provider.of<DestinationProvider>(context).destinations;
    return DestinationGridView(destinations: destinations);
  }
}


// import 'package:flutter/material.dart';
// import 'package:hero_anim/pages/favorites_page.dart';
// import 'package:hero_anim/pages/home/destination_grid_view.dart';
// import 'package:hero_anim/provider/destination_provider.dart';
// import 'package:hero_anim/widget/drawer_widget.dart';
// import 'package:hero_anim/widget/my_appbar.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final destinations = Provider.of<DestinationProvider>(context).destinations;

//     return Scaffold(
//       appBar: MyAppBar(
//         title: "Travel Destination",
        
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.favorite),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const FavoritePage()),
//               );
//             },
//           )
//         ],
//       ),
//       drawer: DrawerWidget(
//         userName: "Jane Smith",
//         userEmail: "jane@example.com",
//         profileImageUrl: "images/profile.jpg",
//       ),
//       body: DestinationGridView(destinations: destinations),
//     );
//   }
// }
