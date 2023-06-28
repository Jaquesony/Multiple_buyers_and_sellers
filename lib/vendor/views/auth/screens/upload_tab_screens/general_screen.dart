import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiple_vendor/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralScreen extends StatefulWidget {
  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> _categoryList = [];

  _getCategories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');
    final outPutDate = outPutDateFormate.format(date);
    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Andika Jina la Bidhaa';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFromData(productName: value);
                },
                decoration: InputDecoration(
                  labelText: 'Jina la Bidhaa',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Andika Bei ya Bidhaa';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFromData(
                      productPrice: double.parse(value));
                },
                decoration: InputDecoration(
                  labelText: 'Bei ya Bidhaa',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Andika Kiasi cha Bidhaa';
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFromData(quantity: int.parse(value));
                },
                decoration: InputDecoration(
                  labelText: 'Kiasi cha Bidhaa',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DropdownButtonFormField(
                // validator: (value){
                //   if(value!.isEmpty){
                //     return 'Select Category';
                //   }else{
                //     return null;
                //   }
                // },
                hint: Text('Chagua Kategoria ya Bidhaa'),
                items: _categoryList.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _productProvider.getFromData(category: value);
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Andika Maelezo ya Bidhaa';
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFromData(description: value);
                },
                minLines: 3,
                maxLines: 10,
                maxLength: 800,
                decoration: InputDecoration(
                  labelText: 'Maelezo ya Bidhaa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(5000),
                      ).then((value) {
                        setState(() {
                          _productProvider.getFromData(scheduleDate: value);
                        });
                      });
                    },
                    child: Text('Muda' ,style: TextStyle(fontSize: 20),),
                  ),
                  if (_productProvider.productData['scheduleDate'] != null)
                    Text(
                      formatedDate(
                        _productProvider.productData['scheduleDate'],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    );
  }
}
