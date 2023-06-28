import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiple_vendor/views/buyers/messages/chat_page.dart';
import 'package:url_launcher/url_launcher.dart';

// import '../messages/chat_page.dart';

class CustomerOrderScreen extends StatelessWidget {
  String formatedDate(date) {
    final outputDateFormate = DateFormat('dd/MM/yyyy');
    final outPutDate = outputDateFormate.format(date);

    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('orderDate', descending: true)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(
          'ODA ZANGU',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 4),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.yellow.shade900,
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Column(
                children: [
                  ListTile(
                    iconColor: Colors.blue,
                    leading: document['accepted'] == true
                        ? Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(color: Colors.green),
                            child: Center(
                              child: Text(
                                'Imekubaliwa',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        // Icon(Icons.delivery_dining)
                        : Container(
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(color: Colors.red),
                            child: Center(
                              child: Text(
                                'Haija kubaliwa',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                    // CircleAvatar(
                    //   backgroundColor: Colors.white,
                    //   radius: 14,
                    //   child: document['accepted'] == true
                    //       ? Icon(Icons.delivery_dining)
                    //       : Icon(Icons.access_time),
                    // ),
                    title: Text(
                      document['productName'],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.shade900,
                      ),
                    ),
                    // document['accepted'] == true
                    //     ? Text(
                    //         'Accepted',
                    //         style: TextStyle(color: Colors.yellow.shade900),
                    //       )
                    //     : Text(
                    //         'Not Accepted',
                    //         style: TextStyle(color: Colors.red),
                    //       ),
                    trailing: Text(
                      formatedDate(
                        document['orderDate'].toDate(),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.shade900,
                      ),
                    ),
                    // Text(
                    //   'Amount ' +
                    //       ' ' +
                    //       'Tshs' +
                    //       ' ' +
                    //       document['productPrice'].toStringAsFixed(2),
                    //   style: TextStyle(
                    //     color: Colors.blue.shade400,
                    //     fontSize: 17,
                    //   ),
                    // ),
                    // subtitle: Text(
                    //   formatedDate(
                    //     document['orderDate'].toDate(),
                    //   ),
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.blue.shade400,
                    //   ),
                    // ),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Taarifa za Oda',
                      style: TextStyle(
                        color: Colors.yellow.shade900,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Angalia Taarifa za Oda',
                      style: TextStyle(fontSize: 18,color: Colors.blue,),
                    ),
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Image.network(document['productImage'][0]),
                        ),
                        title: Text(document['productName']),
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  ('Idadi'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                Text(
                                  document['quantity'].toString(),
                                  style: TextStyle(
                                    color: Colors.yellow.shade900,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  ('Kiasi'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                Text(
                                  document['productPrice'].toStringAsFixed(2),
                                  style: TextStyle(
                                    color: Colors.yellow.shade900,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            document['accepted'] == true
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Tarehe ya kwenda\n kuchukua mzigo',
                                        style: TextStyle(
                                            color: Colors.grey.shade800),
                                      ),
                                      Text(
                                        formatedDate(
                                          document['scheduleDate'].toDate(),
                                        ),
                                        style: TextStyle(
                                            color: Colors.yellow.shade900,fontSize: 16,),
                                      ),
                                    ],
                                  )
                                : Visibility(visible: false,child: Text('')),
                            Column(
                              children: [
                                document['accepted'] == true
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Asubuhi Kuanzia',
                                                style: TextStyle(
                                                    color: Colors.grey.shade800,fontSize: 14),
                                              ),
                                               Text(
                                                'Saa 2:00',
                                                style: TextStyle(
                                                    color: Colors.yellow.shade900,fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Jioni Mwisho',
                                                style: TextStyle(
                                                    color: Colors.grey.shade800,fontSize: 14),
                                              ),
                                              Text(
                                                'Saa 12:00',
                                                style: TextStyle(
                                                    color: Colors.yellow.shade900,fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Text(''),
                                Builder(builder: (context) {
                                  CollectionReference users = FirebaseFirestore
                                      .instance
                                      .collection('vendors');
                                  return FutureBuilder<DocumentSnapshot>(
                                    future:
                                        users.doc(document['vendorId']).get(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                            child:
                                                Text("Something went wrong"));
                                      }

                                      if (snapshot.hasData &&
                                          !snapshot.data!.exists) {
                                        return Center(
                                            child: Text(
                                                "Document does not exist"));
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        Map<String, dynamic> data =
                                            snapshot.data!.data()
                                                as Map<String, dynamic>;
                                        // print('dtatatat' + data.toString());
                                        return Text.rich(
                                          TextSpan(
                                            text: "${data['email']}\n",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                if (await canLaunchUrl(Uri.parse(
                                                    "mailto:${data['email']}"))) {
                                                  await launchUrl(Uri.parse(
                                                      "mailto: ${data['email']}"));
                                                }
                                              },
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,color: Colors.blue),
                                            children: [
                                              TextSpan(
                                                text: data['phoneNumber'],
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        if (await canLaunchUrl(
                                                            Uri.parse(
                                                                "tel:${data['phoneNumber']}"))) {
                                                          await launchUrl(Uri.parse(
                                                              "tel: ${data['phoneNumber']}"));
                                                        }
                                                      },
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold,color: Colors.blue),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.yellow.shade900,
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ],
                            ),
                            ListTile(
                              // title: Text(
                              //   'Buyer Detail',
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //   ),
                              // ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.message,
                                      color: Colors.blue,
                                    ),
                                    title: Text(
                                      ' Messages',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Builder(builder: (context) {
                                              CollectionReference users =
                                                  FirebaseFirestore.instance
                                                      .collection('users');
                                              return FutureBuilder<
                                                  DocumentSnapshot>(
                                                future: users
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .get(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            DocumentSnapshot>
                                                        snapshot) {
                                                  if (snapshot.hasError) {
                                                    return Center(
                                                        child: Text(
                                                            "Something went wrong"));
                                                  }

                                                  if (snapshot.hasData &&
                                                      !snapshot.data!.exists) {
                                                    return Center(
                                                        child: Text(
                                                            "Document does not exist"));
                                                  }

                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    Map<String, dynamic> data =
                                                        snapshot.data!.data()
                                                            as Map<String,
                                                                dynamic>;
                                                    // print('dtatatat' + data.toString());
                                                    return chatpage(
                                                      dataOrder: document,
                                                      userData: data,
                                                    );
                                                  }
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors
                                                          .yellow.shade900,
                                                    ),
                                                  );
                                                },
                                              );
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  // Text(document['fullName']),
                                  // Text(document['email']),
                                  // Text(document['address']),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
