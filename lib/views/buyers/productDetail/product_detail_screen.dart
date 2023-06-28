import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiple_vendor/provider/cart_provider.dart';
import 'package:multiple_vendor/utilits/show_snackBack.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/widgets/google_maps.dart';
import 'package:multiple_vendor/views/buyers/main_screen.dart';
import 'package:multiple_vendor/views/buyers/nav_screens/cart_screen.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;
  final dynamic vendorData;

  const ProductDetailScreen(
      {super.key, required this.productData, this.vendorData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');
    final outPutDate = outPutDateFormate.format(date);
    return outPutDate;
  }

  int _imageIndex = 0;
  String? _selectedSize;
  String? _selectedColor;
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Positioned(
            child: IconButton(
          onPressed: () => Get.to(
            () => MainScreen(),
          ),
          icon: Icon(Icons.arrow_back),
        )),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 5),
        ),
        actions: [
          _cartProvider.getCartItem.containsKey(widget.productData['productId'])
              ? TextButton(
                  onPressed: () {
                    Get.to(()=>CartScreen());
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return CartScreen();
                    // }));
                  },
                  child: Column(
                    children: [
                      Icon(Icons.shopping_cart_checkout_outlined,color: Colors.blue,),
                      Text('Bonyeza Hapa')
                    ],
                  ),
                )
              : Text(''),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              CarouselSlider.builder(
                itemCount: widget.productData['imageUrlList'].length,
                itemBuilder: (context, index, _) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    child: PhotoView(
                      imageProvider: NetworkImage(
                        widget.productData['imageUrlList'][index],
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _imageIndex = index;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      'TZS' +
                          ' ' +
                          widget.productData['productPrice'].toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.shade900,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.productData['productName'],
                        style: TextStyle(
                          fontSize: 22,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.productData['quantity'] < 1
                            ? 'No pieces'
                            : '${widget.productData['quantity']}' +
                                ' ' +
                                'pieces',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      )
                    ],
                  ),
                  if (widget.productData['model'] != null)
                    Container(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Model',
                            style: TextStyle(
                              color: Colors.yellow.shade900,
                            ),
                          ),
                          Text(
                            widget.productData['model'],
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 3,
                  ),
                  if (widget.productData['ram'] != null)
                    Container(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ram',
                            style: TextStyle(
                              color: Colors.yellow.shade900,
                            ),
                          ),
                          Text(
                            widget.productData['ram'],
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 3,
                  ),
                  if (widget.productData['hardDrive'] != null)
                    Container(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hard Drive',
                            style: TextStyle(
                              color: Colors.yellow.shade900,
                            ),
                          ),
                          Text(
                            widget.productData['hardDrive'],
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 3,
                  ),
                  if (widget.productData['year'] != null)
                    Container(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Year',
                            style: TextStyle(
                              color: Colors.yellow.shade900,
                            ),
                          ),
                          Text(
                            widget.productData['year'],
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 3,
                  ),
                  if (widget.productData['cpu'] != null)
                    Container(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'CPU',
                            style: TextStyle(
                              color: Colors.yellow.shade900,
                            ),
                          ),
                          Text(
                            widget.productData['cpu'],
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 3,
                  ),
                  ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Maelezo ya bidhaa',
                          style: TextStyle(
                            color: Colors.yellow.shade900,
                          ),
                        ),
                        Text(
                          'Ona Zaidi',
                          style: TextStyle(
                            color: Colors.yellow.shade900,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.productData['description'],
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                            letterSpacing: 3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Rangi Zilizopo',
                      style: TextStyle(color: Colors.yellow.shade900),
                    ),
                    children: [
                      Container(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.productData['colorList'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: _selectedColor ==
                                          widget.productData['colorList'][index]
                                      ? Colors.yellow.shade900
                                      : null,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedColor = widget
                                            .productData['colorList'][index];
                                      });
                                      print(_selectedColor);
                                    },
                                    child: Text(
                                      widget.productData['colorList'][index],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Size Zilizopo',
                      style: TextStyle(color: Colors.yellow.shade900),
                    ),
                    children: [
                      Container(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.productData['sizeList'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: _selectedSize ==
                                          widget.productData['sizeList'][index]
                                      ? Colors.yellow.shade900
                                      : null,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedSize = widget
                                            .productData['sizeList'][index];
                                      });
                                      print(_selectedSize);
                                    },
                                    child: Text(
                                      widget.productData['sizeList'][index],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Text(
                  //       'Kiwango Kilichopo',
                  //       style: TextStyle(
                  //         color: Colors.yellow.shade900,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 18,
                  //       ),
                  //     ),
                  //     Text(
                  //       widget.productData['quantity'] < 1
                  //           ? 'No product'
                  //           : '${widget.productData['quantity']}' +
                  //               ' ' +
                  //               'pieces',
                  //       style: TextStyle(
                  //           color: Colors.blue,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //           letterSpacing: 1),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Eneo la Biashara',
                style: TextStyle(fontSize: 20, letterSpacing: 4,color: Colors.blue),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Builder(builder: (context) {
                      CollectionReference users =
                          FirebaseFirestore.instance.collection('vendors');
                      return FutureBuilder<DocumentSnapshot>(
                        future: users.doc(widget.productData['vendorId']).get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text("Something went wrong"));
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return Center(
                                child: Text("Document does not exist"));
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            // print('dtatatat' + data.toString());
                            return LocalMaps(
                              latitude: data['latitude'],
                              longitude: data['longitude'],
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
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.getCartItem
                  .containsKey(widget.productData['productId'])
              ? null
              : () {
                  if (_selectedColor == null || _selectedSize == null) {
                    return showSnack(context, 'Tafadhari chagua size na rangi');
                  } else {
                    _cartProvider.addProductToCart(
                      widget.productData['productName'],
                      widget.productData['productId'],
                      widget.productData['imageUrlList'],
                      1,
                      widget.productData['quantity'],
                      widget.productData['productPrice'],
                      widget.productData['vendorId'],
                      _selectedSize!,
                      _selectedColor!,
                      widget.productData['scheduleDate'],
                    );
                    return showSnack(context,
                        'Tayari ${widget.productData['productName']} ipo kwenye kikapu');
                  }
                },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: _cartProvider.getCartItem
                      .containsKey(widget.productData['productId'])
                  ? Colors.grey
                  : Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _cartProvider.getCartItem
                          .containsKey(widget.productData['productId'])
                      ? Text(
                          'TAYARI IPO KWENYE KIKAPU',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            letterSpacing: 3,
                          ),
                        )
                      : Text(
                          'WEKA KWENYE KIKAPU',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 3,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
