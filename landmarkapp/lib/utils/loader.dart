import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static loader() {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return const Center(
            child: CircularProgressIndicator(
          color: Color.fromRGBO(108, 99, 255, 1.0),
        ));
      },
    );
  }
}
