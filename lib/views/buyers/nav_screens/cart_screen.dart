import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiple_vendor/provider/cart_provider.dart';
import 'package:multiple_vendor/views/buyers/auth/login_screen.dart';
import 'package:multiple_vendor/views/buyers/inner_screens/checkout_screen.dart';
import 'package:multiple_vendor/views/buyers/main_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // leading: Positioned(
        //     child: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Get.to(() => MainScreen()),
        // )),
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(
          '',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            child: _cartProvider.totalPrice == 0.00
                ? null
                : IconButton(
                    onPressed: () {
                      _cartProvider.removeAllItem();
                    },
                    icon: Icon(CupertinoIcons.delete),
                  ),
          ),
        ],
      ),
      body: _cartProvider.getCartItem.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: _cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData =
                    _cartProvider.getCartItem.values.toList()[index];
                return Card(
                  child: SizedBox(
                    height: 170,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(cartData.imageUrl[0]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartData.productName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                                Text(
                                  'TZS' +
                                      ' ' +
                                      cartData.price.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      color: Colors.yellow.shade900),
                                ),
                                Row(
                                  children: [
                                    OutlinedButton(
                                      onPressed: null,
                                      child: Text(
                                        cartData.productSize,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    OutlinedButton(
                                      onPressed: null,
                                      child: Text(
                                        cartData.productColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 115,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: cartData.quantity == 1
                                                ? null
                                                : () {
                                                    _cartProvider
                                                        .decreament(cartData);
                                                  },
                                            icon: Icon(
                                              CupertinoIcons.minus,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            cartData.quantity.toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          IconButton(
                                            onPressed: cartData
                                                        .productQuantity ==
                                                    cartData.quantity
                                                ? null
                                                : () {
                                                    _cartProvider
                                                        .increament(cartData);
                                                  },
                                            icon: Icon(
                                              CupertinoIcons.plus,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _cartProvider
                                            .removeItem(cartData.productId);
                                      },
                                      icon: Icon(
                                        CupertinoIcons.cart_badge_minus,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hakuna Bidhaa kwenye Kikapu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MainScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'ENDELEA KUNUNUA',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomSheet: FirebaseAuth.instance.currentUser == null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: _cartProvider.totalPrice == 0.00
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _cartProvider.totalPrice == 0.00
                        ? Colors.grey
                        : Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    'Tshs' +
                        ' ' +
                        _cartProvider.totalPrice.toStringAsFixed(2) +
                        ' ' +
                        'JIUNGE KWANZA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: _cartProvider.totalPrice == 0.00
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CheckoutScreen();
                            },
                          ),
                        );
                      },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _cartProvider.totalPrice == 0.00
                        ? Colors.grey
                        : Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    'MALIPO' +
                        ' ' +
                        'Tshs' +
                        ' ' +
                        _cartProvider.totalPrice.toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            ),
    );
  }
}
