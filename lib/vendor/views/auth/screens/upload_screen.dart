import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multiple_vendor/provider/product_provider.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/main_vendor_screen.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/upload_tab_screens/attribute_tab_screen.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/upload_tab_screens/general_screen.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/upload_tab_screens/image_tab_screen.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/upload_tab_screens/shipping_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow.shade900,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('Kwa Ujumla'),
                ),
                // Tab(
                //   child: Text('Shipping'),
                // ),
                Tab(
                  child: Text('Sifa ya Bidhaa'),
                ),
                Tab(
                  child: Text('Picha'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GeneralScreen(),
              // ShippingScreen(),
              AttributeTabScreen(),
              ImageTabScreen(),
            ],
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () async {
                EasyLoading.show(status: 'Please Wait...');
                if (_formKey.currentState!.validate()) {
                  final productId = Uuid().v4();
                  await _firestore.collection('products').doc(productId).set({
                    'productId': productId,
                    'productName': _productProvider.productData['productName'],
                    'productPrice':
                        _productProvider.productData['productPrice'],
                    'quantity': _productProvider.productData['quantity'],
                    'category': _productProvider.productData['category'],
                    'description': _productProvider.productData['description'],
                    'scheduleDate':
                        _productProvider.productData['scheduleDate'],
                    'imageUrlList':
                        _productProvider.productData['imageUrlList'],
                    'chargeShipping':
                        _productProvider.productData['chargeShipping'],
                    'shippingCharge':
                        _productProvider.productData['shippingCharge'],
                    'brandName': _productProvider.productData['brandName'],
                    'sizeList': _productProvider.productData['sizeList'],
                    'model': _productProvider.productData['model'],
                    'ram': _productProvider.productData['ram'],
                    'hardDrive': _productProvider.productData['hardDrive'],
                    'year': _productProvider.productData['year'],
                    'cpu': _productProvider.productData['cpu'],
                    'colorList': _productProvider.productData['colorList'],
                    'screenSize': _productProvider.productData['screenSize'],
                    'vendorId': FirebaseAuth.instance.currentUser!.uid,
                    'approved': false,
                  }).whenComplete(() {
                    _productProvider.clearData();
                    _formKey.currentState!.reset();
                    EasyLoading.dismiss();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MainVendorScreen();
                    }));
                  });
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Hifadhi',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
