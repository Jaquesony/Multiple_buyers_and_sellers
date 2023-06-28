import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';

class WithdrawalScreen extends StatelessWidget {
  // final TextEditingController amountControler = TextEditingController();

  late String amount;
  late String name;
  late String mobile;
  late String bankName;
  late String bankAccountName;
  late String bankAccountNumber;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(
          'Withdraw',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  // controller: amountControler,
                  onChanged: (value) {
                    amount = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Field must not be empty';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Amount'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    name = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Name must not be empty';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    mobile = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mobile must not be empty';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Mobile'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    bankName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bank Name msut not be empty';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration:
                      InputDecoration(labelText: 'Bank Name, etc CRDB Bank'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    bankAccountName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bank Account msut not be empty';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Bank Account Name, Eg Renatusi'),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    bankAccountNumber = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bank Account Number msut not be empty';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Bank Account Number'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // EasyLoading.show(status: 'Please wait');
                      var withdrawId = Uuid().v4();
                      await _firestore
                          .collection('widthdrawal')
                          .doc(withdrawId)
                          .set({
                        "withdrawId": withdrawId,
                        "Amount": amount,
                        "Name": name,
                        "Mobile": mobile,
                        "BankName": bankName,
                        "BankAccountName": bankAccountName,
                        "BankAccountNumber": bankAccountNumber,
                      });

                      print('cool');
                    } else {
                      print('False');
                    }
                  },
                  child: Text(
                    'GET CASH',
                    style: TextStyle(fontSize: 18),
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
