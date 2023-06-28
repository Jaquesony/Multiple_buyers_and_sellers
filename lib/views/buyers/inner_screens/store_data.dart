import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class StoreDataProvider extends ChangeNotifier {
  DocumentSnapshot? storeData;

  void updateStoreData(DocumentSnapshot newData) {
    storeData = newData;
    notifyListeners();
  }
}
