// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:landmarkapp/model/result_model.dart';

class PredictionCard extends StatelessWidget {
  const PredictionCard({super.key, required this.r});
  final Map r;
  @override
  Widget build(BuildContext context) {
    final model = r["model"] as ResultModel;
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Landmark Prediction',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.file(r['image'], fit: BoxFit.cover),
                SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     SizedBox(
                //       width: MediaQuery.sizeOf(context).width * 0.4,
                //       child: Text(model.landmarkName.toString(),
                //           overflow: TextOverflow.ellipsis,
                //           style: TextStyle(fontWeight: FontWeight.bold)),
                //     ),
                //     SizedBox(
                //         width: MediaQuery.sizeOf(context).width * 0.4,
                //         child: Text(
                //           'Confidence: ${model.confidenceScore.toString()}',
                //           overflow: TextOverflow.ellipsis,
                //         )),
                //   ],
                // ),
                Column(
                  children: [
                    Text(model.landmarkName.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Confidence Score: ${model.confidenceScore.toString()}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
