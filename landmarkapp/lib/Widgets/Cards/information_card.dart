// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landmarkapp/model/result_model.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({super.key, required this.model});
  final ResultModel model;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Landmark Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            SizedBox(
                height: 800.h,
                child: Markdown(data: model.landmarkInformation.toString()))
            // Text(
            //   model.landmarkInformation.toString(),
            //   style: TextStyle(fontSize: 14),
            // ),
          ],
        ),
      ),
    );
  }
}
