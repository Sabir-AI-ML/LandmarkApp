import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  var history = [].obs;
  @override
  getData() async {
    var db = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;
    var data = await db.collection("userhistory").doc(user?.uid).get();
    if (data.exists) {
      print(data.data().toString());
      var visited = data.data()!;
      history.value = visited['visited'] as List;
    }
  }
}
