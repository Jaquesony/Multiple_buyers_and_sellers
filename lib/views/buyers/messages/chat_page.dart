import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'message.dart';

class chatpage extends StatefulWidget {
  final dynamic userData;
  final dynamic dataOrder;
  chatpage({ this.userData, this.dataOrder});
  @override
  _chatpageState createState() => _chatpageState(userData: userData);
}

class _chatpageState extends State<chatpage> {
  dynamic userData;
  _chatpageState({ this.userData});

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.yellow.shade900,
        title: Text(
          "Karibu tuchati",
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              // _auth.signOut().whenComplete(() {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => HomeScreen(),
                //   ),
                // );
              // });
            },
            // child: Text(
            //   "${FirebaseAuth.instance.currentUser!.email}", style: TextStyle(color: Colors.white),
            // ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.79,
                child: messages(
                  userData: userData,
                  orderData: widget.dataOrder,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: message,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 3, 132, 238),
                    hintText: 'message',
                    enabled: true,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.yellow),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.yellow),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    message.text = value!;
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  if (message.text.isNotEmpty) {
                    final messageId = Uuid().v4();
                    fs.collection('Messages').doc(messageId).set({
                      'message': message.text.trim(),
                      'time': DateTime.now(),
                      'orderId': widget.dataOrder['orderId'],
                      'messageId':messageId,
                      'buyerName':widget.userData['fullName'],
                      'buyerId':FirebaseAuth.instance.currentUser!.uid,
                      'vendorId':widget.dataOrder['vendorId'],
                      'email': FirebaseAuth.instance.currentUser!.email,
                      'phoneNumber':widget.userData['phoneNumber'],
                    });

                    message.clear();
                  }
                },
                icon: Icon(Icons.send_sharp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}