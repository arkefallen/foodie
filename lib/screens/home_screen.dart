import 'package:flutter/material.dart';
import 'package:foodie/provider/bottom_navigation_provider.dart';
import 'package:foodie/screens/favorite_restaurant_screen.dart';
import 'package:foodie/screens/restaurant_screen.dart';
import 'package:foodie/screens/search_restaurant_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _listWidget = [
    const RestaurantScreen(),
    const SearchRestaurantScreen(),
    const FavoriteRestaurantScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget
          .elementAt(context.watch<BottomNavigationProvider>().currentIndex),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded), label: "Favorit")
        ],
        currentIndex: context.watch<BottomNavigationProvider>().currentIndex,
        onTap: (index) {
          context.read<BottomNavigationProvider>().setIndex(index);
        },
      ),
    );
  }
}
