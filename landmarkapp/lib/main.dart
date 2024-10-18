// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:landmarkapp/Login/login_controller.dart';
import 'package:landmarkapp/Routes/app_pages.dart';
import 'package:landmarkapp/Routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.lazyPut(() => LoginController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return ScreenUtilInit(
      child: GetMaterialApp(
        initialRoute: AppRoutes.splashScreen,
        debugShowCheckedModeBanner: false,
        getPages: AppPages.pages,
      ),
    );
  }
}
