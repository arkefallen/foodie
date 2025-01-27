import 'package:flutter/material.dart';
import 'package:foodie/screens/restaurant_screen.dart';
import 'package:foodie/screens/search_restaurant_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _listWidget = [
    const RestaurantScreen(),
    const SearchRestaurantScreen(),
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_rounded),
            label: "Restoran",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: "Cari",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
