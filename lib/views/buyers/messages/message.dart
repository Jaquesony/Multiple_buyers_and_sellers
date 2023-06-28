import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class messages extends StatefulWidget {
  dynamic userData;
  final dynamic orderData;
  messages({required this.userData, this.orderData});
  @override
  _messagesState createState() => _messagesState(userData: userData);
}

class _messagesState extends State<messages> {
  dynamic userData;
  _messagesState({this.userData});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
        .collection('Messages')
        // .where('orderId',isEqualTo:orderId)
        .orderBy('time')
        .snapshots();
    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("something is wrong"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // log("We are here");
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot qs = snapshot.data!.docs[index];
            Timestamp t = qs['time'];
            DateTime d = t.toDate();
            // print(d.toString());
            // log("Firebase UUID: "+FirebaseAuth.instance.currentUser!.uid);
            // log(qs["orderId"]);
            return qs['orderId'] == widget.orderData['orderId']
                ? Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 8),
                    child: Builder(builder: (context) {
                      return Row(
                        mainAxisAlignment:
                            FirebaseAuth.instance.currentUser!.email ==
                                    qs['email']
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: FirebaseAuth.instance.currentUser!.uid ==
                                      qs['buyerId']
                                  ? Color.fromARGB(255, 147, 240, 150)
                                  : Color.fromARGB(255, 125, 187, 238),
                            ),
                            child: SizedBox(
                              width: 300,
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.yellow.shade900,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                title: Text.rich(TextSpan(
                                  text:
                                      FirebaseAuth.instance.currentUser!.uid ==
                                              qs['buyerId']
                                          ? 'Mimi'
                                          : '${qs['buyerName']}' +
                                              ' ' +
                                              '(${qs['phoneNumber']})',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (await canLaunchUrl(Uri.parse(
                                          'tel:${qs['phoneNumber']}'))) {
                                        await launchUrl(Uri.parse(
                                            "tel: ${qs['phoneNumber']}"));
                                      }
                                    },
                                  style: TextStyle(fontSize: 18,color: Colors.black54),
                                )),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        qs['message'],
                                        softWrap: true,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      d.hour.toString() +
                                          ":" +
                                          d.minute.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  )
                : Center(
                    child: Visibility(
                      visible: false,
                      child: Text(''),
                    ),
                  );
          },
        );
      },
    );
  }
}
