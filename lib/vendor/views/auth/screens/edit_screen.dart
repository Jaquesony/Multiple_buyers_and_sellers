import 'package:flutter/material.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/edit_products_tabs/endedProduct.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/edit_products_tabs/published_tab.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/edit_products_tabs/unpublished_tab.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.yellow.shade900,
          title: Text(
            'Simamia Bidhaa',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 4),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Bidhaa iliyo Tangazwa'),
              ),
              Tab(
                child: Text('Bidhaa isiyo Tangazwa'),
              ),
              Tab(
                child: Text('Bidhaa zilizo Isha'),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PublishedTab(),
            UnPublishedTab(),
            EndedProduct(),
          ],
        ),
      ),
    );
  }
}
