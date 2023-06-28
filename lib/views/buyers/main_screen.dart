import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_vendor/views/buyers/nav_screens/account_screen.dart';
import 'package:multiple_vendor/views/buyers/nav_screens/category_screen.dart';
import 'package:multiple_vendor/views/buyers/nav_screens/home_screen.dart';
import 'package:multiple_vendor/views/buyers/nav_screens/store_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    // CartScreen(),
    // SearchScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _pageIndex,
              onTap: (value) {
                setState(() {
                  _pageIndex = value;
                });
              },
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.yellow.shade900,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.home,
                    size: 30.0,
                    color: Colors.blue,
                  ),
                  label: 'HOME',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/explore.png",
                    width: 30.0,
                    color: Colors.blue,
                  ),
                  label: 'KATEGORIA',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/shop.png",
                    width: 30.0,
                    color: Colors.blue,
                  ),
                  label: 'WAUZAJI',
                ),
                // BottomNavigationBarItem(
                //   icon: Image.asset(
                //     "assets/icons/cart.png",
                //     width: 20.0,
                //   ),
                //   label: 'CART',
                // ),
                // BottomNavigationBarItem(
                //   icon: Image.asset(
                //     "assets/icons/search.png",
                //     width: 20.0,
                //   ),
                //   label: 'SEARCH',
                // ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/account.png",
                    width: 30.0,
                    color: Colors.blue,
                  ),
                  label: 'AKAUNTI',
                ),
              ],
            ),
            body: _pages[_pageIndex],
          );
  }
}
