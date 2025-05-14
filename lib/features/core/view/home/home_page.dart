import 'package:hero_anim/imports.dart';

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
    // const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _currentIndex == 0
            ? MyAppBar(
                title: "Travel Destination",
                actions: [
                  // IconButton(
                  //   icon: const Icon(Icons.person),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       PageTransitionAnimation(
                  //           builder: (_) => const ProfilePage()),
                  //     );
                  //   },
                  // )
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      child: Hero(
                        tag: 'profile_image',
                        child: CircleAvatar(
                          radius: 20, // Smaller radius for app bar
                          backgroundImage: AssetImage(AppAssets.kProfile),
                          // child: Image.asset(AppAssets.kProfile)
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : null,
        drawer: _currentIndex == 0
            ? DrawerWidget(
                userName: "Robert Downey Jr.",
                userEmail: "rdj@marvel.com",
                profileImageUrl: "assets/images/profile.jpg",
              )
            : null,
        body:
            KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ));
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
