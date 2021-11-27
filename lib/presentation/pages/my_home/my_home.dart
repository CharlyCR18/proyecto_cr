import 'package:flutter/material.dart';
import 'package:nike_store/presentation/pages/all_sneakers/all_sneakers.dart';
import 'package:nike_store/presentation/pages/cart/cart.dart';
import 'package:nike_store/presentation/pages/liked/liked.dart';
import 'package:nike_store/presentation/pages/profile/profile.dart';
import 'package:nike_store/presentation/pages/search/search.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _currentIndex = 0;

  final _pages = const [
    AllSneakers(),
    Search(),
    Liked(),
    Cart(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profiles"),
        ],
      ),
    );
  }
}