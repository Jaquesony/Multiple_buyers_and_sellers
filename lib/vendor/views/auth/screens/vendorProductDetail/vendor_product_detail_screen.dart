import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiple_vendor/utilits/show_snackBack.dart';

class VendorProductDetail extends StatefulWidget {
  final dynamic productData;

  const VendorProductDetail({super.key, required this.productData});

  @override
  State<VendorProductDetail> createState() => _VendorProductDetailState();
}

class _VendorProductDetailState extends State<VendorProductDetail> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _productNameController.text = widget.productData['productName'];
      _brandNameController.text = widget.productData['brandName'];
      _quantityController.text = widget.productData['quantity'].toString();
      _productPriceController.text =
          widget.productData['productPrice'].toStringAsFixed(2);
      _productDescriptionController.text = widget.productData['description'];
      _categoryNameController.text = widget.productData['category'];
    });
    super.initState();
  }

  double? productPrice;
  int? productQuantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.yellow.shade900,
        title: Text(
          widget.productData['productName'],
          style: TextStyle(letterSpacing: 4),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            TextFormField(
              controller: _productNameController,
              decoration: InputDecoration(
                  labelText: 'Jina la Bidhaa',
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 19)),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _brandNameController,
              decoration: InputDecoration(
                  labelText: 'Jina la Brand',
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 19)),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                productQuantity = int.parse(value);
              },
              controller: _quantityController,
              decoration: InputDecoration(
                  labelText: 'Idadi',
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 19)),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                productPrice = double.parse(value);
              },
              controller: _productPriceController,
              decoration: InputDecoration(
                  labelText: 'Kiasi',
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 19)),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLength: 800,
              maxLines: 3,
              controller: _productDescriptionController,
              decoration: InputDecoration(
                  labelText: 'Maelezo ya Bidhaa',
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 19)),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              enabled: false,
              controller: _categoryNameController,
              decoration: InputDecoration(
                  labelText: 'Kategoria ya Bidhaa',
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 19)),
            ),
          ]),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () async {
            if (productPrice != null && productQuantity != null) {
              await _firestore
                  .collection('products')
                  .doc(widget.productData['productId'])
                  .update({
                'productName': _productNameController.text,
                'brandName': _brandNameController.text,
                'quantity': productQuantity,
                'productPrice': productPrice,
                'description': _productDescriptionController.text,
                'category': _categoryNameController.text,
              });
            } else {
              showSnack(context, 'Badilisha Kiasi na Idadi Pia');
            }
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'HIFADHI MABADILIKO YA BIDHAA',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 4,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
