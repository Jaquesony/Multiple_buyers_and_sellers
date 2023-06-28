import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multiple_vendor/views/buyers/auth/login_screen.dart';
import 'package:multiple_vendor/views/buyers/nav_screens/cart_screen.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hello ,Karibu Kwenye\n App Yetu Mambo ni 🔥',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
            ),
          ),
          FirebaseAuth.instance.currentUser == null
              ? Container(
                  child: GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.person,
                        ),
                        Text(
                          'Ingia/Jiunge',
                          style: TextStyle(),
                        )
                      ],
                    ),
                  ),
                )
              : FutureBuilder<DocumentSnapshot>(
                  future:
                      users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Something went wrong"));
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return GestureDetector(
                        onTap: () async{
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.person,
                            ),
                            Text(
                              'Ingia/Jiunge',
                              style: TextStyle(),
                            )
                          ],
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          Text('Hello',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                          Text(data['fullName'],style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                        ],
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow.shade900,
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
