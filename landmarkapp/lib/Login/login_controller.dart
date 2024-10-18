// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  login({required String emailAddress, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided for that user.';
          break;
        default:
          message = 'Either wrong credentials or no internet connection.';
      }
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      print(message);
      return false;
    }
  }
}
