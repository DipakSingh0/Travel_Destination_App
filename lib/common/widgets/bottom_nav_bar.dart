// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  double _iconSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (index) {
        setState(() {
          _iconSize = 24.0; // Reset icon size
        });
        widget.onTap(index);
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: Icon(
              Icons.home,
              size: widget.currentIndex == 0 ? _iconSize + 6 : _iconSize,
            ),
          ),
          label: 'Home', 
        ),
        BottomNavigationBarItem(
          icon: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: Icon(
              Icons.landscape,
              size: widget.currentIndex == 1 ? _iconSize + 6 : _iconSize,
            ),
          ),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: Icon(
              Icons.favorite,
              size: widget.currentIndex == 2 ? _iconSize + 6 : _iconSize,
            ),
          ),
          label: 'Favorites',
        ),
        // BottomNavigationBarItem(
        //   icon: AnimatedContainer(
        //     duration: const Duration(milliseconds: 400),
        //     curve: Curves.easeInOut,
        //     child: Icon(
        //       Icons.person,
        //       size: widget.currentIndex == 3 ? _iconSize + 6 : _iconSize,
        //     ),
        //   ),
        //   label: 'Profile',
        // ),
      ],
    );
  }
}
