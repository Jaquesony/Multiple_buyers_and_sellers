import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiple_vendor/controllers/auth_controller.dart';
import 'package:multiple_vendor/utilits/show_snackBack.dart';
import 'package:multiple_vendor/vendor/views/auth/vendor_auth.dart';
import 'package:multiple_vendor/views/buyers/auth/login_screen.dart';
import 'package:multiple_vendor/views/buyers/auth/register_screen.dart';
import 'package:multiple_vendor/views/buyers/main_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Weka upya nenosiri",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Barua pepe haiwezi kuwa tupu';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(labelText: 'Barua pepe'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email)
                        .then(
                          (val) => Get.to(() => LoginScreen()),
                        );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Rudisha nenosiri',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5,
                              ),
                            ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text('Need to login?'),
                //     TextButton(
                //       onPressed: () {
                //         Get.to(() => LoginScreen());
                //         // Navigator.pushReplacement(context,
                //         //     MaterialPageRoute(builder: (context) {
                //         //   return BuyerRegisterScreen();
                //         // }));
                //       },
                //       child: Text('ingia'),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text('Need Seller Account?'),
                //     TextButton(
                //       onPressed: () {
                //         Navigator.pushReplacement(context,
                //             MaterialPageRoute(builder: (context) {
                //           return VendorAuthScreen();
                //         }));
                //       },
                //       child: Text('Ingia'),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
