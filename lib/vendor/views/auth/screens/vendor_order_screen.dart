import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../views/buyers/messages/chat_page.dart';

class VendorOrderScreen extends StatelessWidget {
  String formatedDate(date) {
    final outputDateFormate = DateFormat('dd/MM/yyyy');
    final outPutDate = outputDateFormate.format(date);

    return outPutDate;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('orderDate',descending: true)
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
              // print(document['fullName']);
              return Slidable(
                child: Column(
                  children: [
                    ListTile(
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
                      title: Expanded(
                        child: Text(
                          document['fullName'],
                          style: TextStyle(
                            // fontSize: 12,
                            // fontWeight: FontWeight.bold,
                            color: Colors.yellow.shade900,
                          ),
                        ),
                      ),
                      // document['accepted'] == true
                      //     ? Text(
                      //         'Imekubaliwa',
                      //         style: TextStyle(color: Colors.green, fontSize: 22,fontWeight: FontWeight.bold),
                      //       )
                      //     : Text(
                      //         'Haija kubaliwa',
                      //         style: TextStyle(color: Colors.red),
                      //       ),
                      trailing: Expanded(
                        child: Text(
                          ' ' +
                              formatedDate(
                                document['orderDate'].toDate(),
                              ),
                          style: TextStyle(
                            color: Colors.yellow.shade900,
                            // fontSize: 14,
                          ),
                        ),
                      ),
                      // subtitle: Text(
                      //     document['fullName'],
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.red,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    ('Idadi'),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    document['quantity'].toString(),
                                    style: TextStyle(fontSize: 17,color: Colors.yellow.shade900),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    ('Kiasi'),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    document['productPrice'].toStringAsFixed(2),
                                    style: TextStyle(
                                        color: Colors.yellow.shade900,
                                        fontSize: 17,),
                                  ),
                                ],
                              ),
                              // document['accepted'] == true
                              //     ? Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceEvenly,
                              //         children: [
                              //           Text(
                              //             "Tarehe ya Kuja\n kuchukua mzigo",
                              //             style: TextStyle(
                              //                 fontSize: 17,
                              //                 fontWeight: FontWeight.bold),
                              //           ),
                              //           Text(
                              //             formatedDate(
                              //               document['scheduleDate'].toDate(),
                              //             ),
                              //             style: TextStyle(
                              //                 fontSize: 17,
                              //                 fontWeight: FontWeight.bold),
                              //           ),
                              //         ],
                              //       )
                              //     : Text(''),
                              ListTile(
                                title: Text(
                                  'Taarifa za Mteja',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document['fullName'],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: "${document['email']}\n",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            if (await canLaunchUrl(Uri.parse(
                                                "mailto:${document['email']}"))) {
                                              await launchUrl(Uri.parse(
                                                  "mailto: ${document['email']}"));
                                            }
                                          },
                                          children: [
                                             TextSpan(
                                        text: document['phone'],
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            if (await canLaunchUrl(Uri.parse(
                                                "tel:${document['phone']}"))) {
                                              await launchUrl(Uri.parse(
                                                  "tel: ${document['phone']}"));
                                            }
                                          },
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,color: Colors.blue),
                                      ),
                                          ],
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,color: Colors.blue),
                                      ),
                                    ),
                                    if(document['address'] != null)
                                    Text(
                                      document['address'],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.message,color: Colors.blue,),
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
                                    return FutureBuilder<DocumentSnapshot>(
                                      future: users
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .get(),
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
                                          return chatpage(
                                            dataOrder: document,
                                            userData: data,
                                          );
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
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      flex: 2,
                      onPressed: (context) async {
                        await _firestore
                            .collection('orders')
                            .doc(document['orderId'])
                            .update({
                          'accepted': false,
                        });
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Kataa',
                    ),
                    SlidableAction(
                      flex: 2,
                      onPressed: (context) async {
                        await _firestore
                            .collection('orders')
                            .doc(document['orderId'])
                            .update({
                          'accepted': true,
                        });
                      },
                      backgroundColor: Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.share,
                      label: 'Kubali',
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
