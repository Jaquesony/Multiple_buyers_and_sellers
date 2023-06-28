import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiple_vendor/controllers/auth_controller.dart';
import 'package:multiple_vendor/utilits/show_snackBack.dart';
import 'package:multiple_vendor/vendor/views/auth/vendor_auth.dart';
import 'package:multiple_vendor/views/buyers/auth/register_screen.dart';
import 'package:multiple_vendor/views/buyers/auth/reset_password.dart';
import 'package:multiple_vendor/views/buyers/main_screen.dart';

import '../../../vendor/views/auth/vendor_register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;

  late String password;

  bool _isLoading = false;
  bool _passwordVisible = false;

  // @override
  // void initState() {
  //   _passwordVisible = false;
  //   super.initState();
  // }

  _loginUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      String res = await _authController.loginUsers(email, password);
      if (res == 'success') {
        return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Builder(builder: (context) {
                CollectionReference users =
                    FirebaseFirestore.instance.collection('users');
                return FutureBuilder<DocumentSnapshot>(
                  future:
                      users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Something went wrong"));
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Center(child: Text("Document does not exist"));
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return data['rolePlayed'] == 'buyer'
                          ? MainScreen()
                          : VendorAuthScreen();
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow.shade900,
                      ),
                    );
                  },
                );
              });
            },
          ),
          (route) => false,
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        return showSnack(context, res);
      }

      // return showSnack(context, 'You Are Now Logged In');
    } else {
      return showSnack(context, 'Please Fields must not be empty');
    }
  }

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
                Text.rich(
                  TextSpan(
                      text: "Ingia ",
                      style: TextStyle(
                          color: Colors.yellow.shade900,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: "mtumiaji",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tafadhari Barua pepe haitakiwi kuwa tupu';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(labelText: 'Ingiza Anuani ya Barua pepe'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 13, right: 13, left: 13, bottom: 2),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tafadhari Neno Siri haitakiwi kuwa tupu';
                      } else {
                        return null;
                      }
                    },
                    obscureText: !_passwordVisible,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Ingiza Neno Siri/Nywila',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                forgetPassword(context),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    _loginUsers();
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
                              'Ingia',
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Unaitaji Akaunti?'),
                    TextButton(
                      onPressed: () {
                        Get.to(() => BuyerRegisterScreen());
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return BuyerRegisterScreen();
                        // }));
                      },
                      child: Text('Jiunge'),
                    ),
                  ],
                ),
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

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          'Umesahau Neno Siri/ Nywila?',
          textAlign: TextAlign.right,
        ),
        onPressed: () {
          Get.to(() => ResetPasswordScreen());
        },
      ),
    );
  }
}
