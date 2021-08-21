import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class FirebaseData {
  Map<String, dynamic>? brandTitle;
  // yeh is liay ta k object k data ko map mai la ayein....

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> getData() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore
            .collection('/nike/collections/basketball')
            .doc("nike")
            .get();
    // yeh jo data aya hai yeh as a object aya hai

    if (documentSnapshot.exists) {
      brandTitle = documentSnapshot.data();
      // ub object wala data map ki form mai hai.
      // ub asani sa key dal k value li ja sakti hai :)

    } else {
      print("Data doesn't exist");
    }
    // ChangeNotifierProvider ko call krny k liay
  }
}

class ForText with ChangeNotifier {
  Map<String, dynamic>? brandTitle;
  // yeh is liay ta k object k data ko map mai la ayein....

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> getData() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore
            .collection('collections-list-screen-text')
            .doc("nike")
            .get();
    // yeh jo data aya hai yeh as a object aya hai

    if (documentSnapshot.exists) {
      brandTitle = documentSnapshot.data();
      // ub object wala data map ki form mai hai.
      // ub asani sa key dal k value li ja sakti hai :)

    } else {
      print("Data doesn't exist");
    }
    notifyListeners();
    // ChangeNotifierProvider ko call krny k liay
  }
}
