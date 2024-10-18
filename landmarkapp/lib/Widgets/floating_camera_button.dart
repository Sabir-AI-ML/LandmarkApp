import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:landmarkapp/Home/home_controller.dart';

FloatingActionButton buildFloatingCameraButton() {
  HomeController homeController = Get.find<
      HomeController>(); // Ensure HomeController is registered in your GetX dependencies
  return FloatingActionButton(
    onPressed: () {
      homeController.uploadFile(isCamera: true);
    },
    child: Icon(
      Icons.camera_alt_sharp,
      color: const Color.fromRGBO(108, 99, 255, 1.0),
      size: 38.sp, // Ensure ScreenUtil is initialized in your main.dart file
    ),
  );
}
