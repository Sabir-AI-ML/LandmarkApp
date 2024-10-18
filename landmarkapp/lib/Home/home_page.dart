// // ignore_for_file: prefer_const_constructors, unused_local_variable

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:landmarkapp/Home/home_controller.dart';
// import 'package:landmarkapp/Widgets/Cards/recommendation_card.dart';
// import 'package:landmarkapp/Widgets/common_appbar.dart';
// import 'package:landmarkapp/Widgets/floating_camera_button.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(
//         context); // Initialize ScreenUtil, only if you're using ScreenUtil
//     final HomeController homeController = Get.put(HomeController());

//     return SafeArea(
//       child: Scaffold(
//         appBar: CommonAppBar(title: 'Home Page'),
//         drawer: CommonDrawer(),
//         floatingActionButton: buildFloatingCameraButton(),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         body: Obx(
//           () => homeController.loading.value
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : SingleChildScrollView(
//                   child: Container(
//                     margin: EdgeInsets.symmetric(
//                         horizontal: 8
//                             .w), // Use .w from ScreenUtil for responsive width, if you're using it.
//                     padding: EdgeInsets.only(
//                         top: 16
//                             .h), // Use .h from ScreenUtil for responsive height, if you're using it.
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                             height: 20
//                                 .h), // Use .h from ScreenUtil for responsive height, if you're using it.
//                         Text(
//                           "You Should Visit Next:",
//                           style: GoogleFonts.urbanist(
//                             fontSize: 26
//                                 .sp, // Use .sp from ScreenUtil for responsive font size, if you're using it.
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(
//                             height: 8
//                                 .h), // Use .h from ScreenUtil for responsive height, if you're using it.

//                         Obx(() => homeController.loading.value
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               :
//                     ),
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }

// ... (existing imports and other code)

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:landmarkapp/Home/home_controller.dart';
import 'package:landmarkapp/Widgets/Cards/recommendation_card.dart';
import 'package:landmarkapp/Widgets/common_appbar.dart';
import 'package:landmarkapp/Widgets/floating_camera_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final HomeController homeController = Get.put(HomeController());

    return SafeArea(
      child: Scaffold(
          appBar: CommonAppBar(title: 'Home Page'),
          drawer: CommonDrawer(),
          floatingActionButton: buildFloatingCameraButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Obx(() => homeController.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 8
                          .w), // Use .w from ScreenUtil for responsive width, if you're using it.
                  padding: EdgeInsets.only(
                      top: 16
                          .h), // Use .h from ScreenUtil for responsive height, if you're using it.
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        var item = homeController.model.recommendation?[index];
                        return GestureDetector(
                          child: RecommendationCard(
                            landmarkName: item!.landmark!,
                            imagePath: item.imageLink!,
                            reason: item.reason!,
                            onVisitTap: () async {
                              // await launchUrl(
                              //     Uri.parse(landmark['landmarkLocation']));
                            },
                          ),
                        );
                      },
                      itemCount: homeController.model.recommendation?.length),
                ))),
    );
  }
}
