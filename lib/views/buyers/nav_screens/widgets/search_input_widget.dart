import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiple_vendor/views/buyers/productDetail/product_detail_screen.dart';

import '../../productDetail/store_detail_screen.dart';

class SearchInputWidget extends StatefulWidget {
  const SearchInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  String _searchedValue = '';
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('approved', isEqualTo: true)
        .snapshots();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchedValue = value;
                });
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Tafuta Bidhaa',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Image.asset(
                    "assets/icons/search.png",
                    width: 10.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        _searchedValue == ''
            ? Text('')
            : StreamBuilder<QuerySnapshot>(
                stream: _productsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  final searchedData = snapshot.data!.docs.where((element) {
                    return element['productName']
                        .toLowerCase()
                        .contains(_searchedValue.toLowerCase());
                  });
                  return Column(
                    children: searchedData.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailScreen(productData: e);
                            },
                          ));
                        },
                        child: Card(
                          child: Builder(builder: (context) {
                            CollectionReference users = FirebaseFirestore
                                .instance
                                .collection('vendors');
                            return FutureBuilder<DocumentSnapshot>(
                              future: users.doc(e['vendorId']).get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text("Something went wrong"));
                                }

                                if (snapshot.hasData &&
                                    !snapshot.data!.exists) {
                                  return Center(
                                      child: Text("Document does not exist"));
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  Map<String, dynamic> data = snapshot.data!
                                      .data() as Map<String, dynamic>;
                                  // print('dtatatat' + data.toString());
                                  return Row(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image.network(
                                          e['imageUrlList'][0],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e['productName'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            e['productPrice']
                                                .toStringAsFixed(2),
                                            style: TextStyle(
                                                color: Colors.yellow.shade900),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(width: 15,),
                                      Expanded(child: Container()),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return StoreDetailScreen(
                                                  storeData: data,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Text(
                                          data['bussinessName'],
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.yellow.shade900,
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
      ],
    );
  }
}
