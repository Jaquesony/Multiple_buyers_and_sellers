import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiple_vendor/views/buyers/inner_screens/all_products_screen.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading:false,
        // leading: Positioned(
        //     child: IconButton(
        //   icon: Icon(Icons.arrow_back,color: Colors.white,),
        //   onPressed: () => Get.to(() => MainScreen()),
        // )),
        centerTitle: true,
        // iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.yellow.shade900,
        title: Text(
          'Kategoria',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.yellow.shade900,
              ),
            );
          }

          return Container(
            height: 550,
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final categoryData = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AllProductScreen(categoryData: categoryData);
                        }));
                      },
                      leading: Image.network(categoryData['image']),
                      title: Text(categoryData['categoryName']),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
