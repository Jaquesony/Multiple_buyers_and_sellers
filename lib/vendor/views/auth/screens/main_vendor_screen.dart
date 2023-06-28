import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/earnings_screen.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/edit_screen.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/upload_screen.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/vendor_logout_screen.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/vendor_order_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;
  List<Widget> _pages = [
    EarningsScreen(),
    UploadScreen(),
    EditScreen(),
    // VendorOrderScreen(),
    VendorLogoutScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.yellow.shade900,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_dollar,size: 40,color: Colors.blue,),
            label: 'MAPATO',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload,size: 40,color: Colors.blue),
            label: 'PAKIA',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit,size: 40,color: Colors.blue),
            label: 'HARIRI',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(CupertinoIcons.shopping_cart),
          //   label: 'ORDERS',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout,size: 40,color: Colors.blue),
            label: 'TOKA',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
