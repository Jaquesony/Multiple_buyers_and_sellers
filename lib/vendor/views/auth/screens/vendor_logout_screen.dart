import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiple_vendor/views/buyers/main_screen.dart';

class VendorLogoutScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          await _auth.signOut().whenComplete(() {
            Get.offAll(() => MainScreen());
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) {
            //   return LoginScreen();
            // }));
          });
        },
        child: Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Ondoka',
              style: TextStyle(fontSize: 25,color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
