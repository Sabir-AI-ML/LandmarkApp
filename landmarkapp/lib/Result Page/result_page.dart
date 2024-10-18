// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landmarkapp/Widgets/Cards/information_card.dart';
import 'package:landmarkapp/Widgets/Cards/prediction_card.dart';
import 'package:landmarkapp/Widgets/common_appbar.dart';

class LandmarkClassifierScreen extends StatelessWidget {
  const LandmarkClassifierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: CommonAppBar(
          title:
              'Landmark Classifier'), // Make sure your CommonAppBar accepts a title parameter
      drawer: CommonDrawer(),
      body: Column(
        children: [
          PredictionCard(
            r: data,
          ),
          InformationCard(model: data["model"]),
        ],
      ),
    );
  }
}
