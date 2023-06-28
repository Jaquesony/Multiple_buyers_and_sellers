import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiple_vendor/vendor/models/vendor_user_models.dart';
import 'package:multiple_vendor/vendor/views/auth/screens/main_vendor_screen.dart';
import 'package:multiple_vendor/vendor/views/auth/vendor_register_screen.dart';
import 'package:multiple_vendor/views/buyers/main_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _vendorsStream =
        FirebaseFirestore.instance.collection('vendors');
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _vendorsStream.doc(_auth.currentUser!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.yellow.shade900,
            ));
          }
          if (!snapshot.data!.exists) {
            return VendorRegistrationScreen();
          }
          VendorUserModel vendorUserModel = VendorUserModel.fromJson(
              snapshot.data!.data()! as Map<String, dynamic>);

          if (vendorUserModel.approved == true) {
            return MainVendorScreen();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    vendorUserModel.storeImage.toString(),
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  vendorUserModel.bussinessName.toString(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text:
                                  "Umetuma maombi ya kujiunga na app kwa admin, Soon Admin atakurudia muda sio mrefu, wasiliana nae kwa namba ya sim na email hizi hapa: "),
                          TextSpan(
                              text: "0686892025\n",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (await canLaunchUrl(
                                      Uri.parse("tel:0686892025"))) {
                                    await launchUrl(
                                        Uri.parse("tel:0686892025"));
                                  }
                                },
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 22,
                                  letterSpacing: 2,
                                  color: Colors.blue)),
                          TextSpan(
                              text: "renatusernest9@gmail.com\n",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (await canLaunchUrl(Uri.parse(
                                      "mailto:renatusernest9@gmail.com"))) {
                                    await launchUrl(Uri.parse(
                                        "mailto:renatusernest9@gmail.com?subject=Hello&body=Hello"));
                                  }
                                },
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 22,
                                  letterSpacing: 2,
                                  color: Colors.blue)),
                          TextSpan(
                              text: 'Rudi Menyu Kuu',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await FirebaseAuth.instance.signOut();
                                  Get.to(() => MainScreen());
                                },
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                fontSize: 22,
                                letterSpacing: 2,
                              )),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                /*Text(
                  'Umetuma maombi ya kujiunga na app kwa admin\n Admin atakurudia muda sio mrefu\n wasiliana nane kwa namba ya sim 0686892025\n renatusie@gmail.com',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),*/
                SizedBox(
                  height: 10,
                ),
                // TextButton(
                //   onPressed: () async {
                //     await _auth.signOut();
                //   },
                //   child: Text('SignOut'),
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}
