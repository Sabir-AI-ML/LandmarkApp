// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:landmarkapp/History%20Page/history_controller.dart';
import 'package:landmarkapp/Home/home_controller.dart';
import 'package:landmarkapp/Widgets/Cards/history_card.dart';
import 'package:landmarkapp/Widgets/common_appbar.dart';
import 'package:landmarkapp/Widgets/floating_camera_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final historyController = Get.find<HistoryController>();
  @override
  void initState() {
    // TODO: implement initState
    historyController.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        context); // Initialize ScreenUtil, only if you're using ScreenUtil
    final HomeController homeController = Get.put(
        HomeController()); // Make sure HomeController is registered in your GetX dependencies

    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(title: 'History'),
        drawer: CommonDrawer(),
        floatingActionButton: buildFloatingCameraButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Obx(
          () => historyController.history.isNotEmpty
              ? ListView.builder(
                  itemCount: historyController.history.length,
                  itemBuilder: (context, index) {
                    final landmark = historyController.history[index];
                    return HistoryCard(
                      imagePath: landmark['landmarkImage']!,
                      landmarkName: landmark['landmarkName']!,
                      onVisitTap: () async {
                        await launchUrl(
                            Uri.parse(landmark['landmarkLocation']));
                      },
                    );
                  },
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
