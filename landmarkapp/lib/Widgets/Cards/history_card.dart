// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String imagePath;
  final String landmarkName;
  final VoidCallback onVisitTap;

  const HistoryCard({
    super.key,
    required this.imagePath,
    required this.landmarkName,
    required this.onVisitTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment
            .start, // Changed to start to better align with a smaller height
        children: [
          Image.network(
            imagePath,
            width: 100.0, // Fixed width
            height: 100.0, // Fixed height
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 12.0), // Reduced vertical padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize
                    .min, // Added to fit the content in the available space
                children: [
                  SizedBox(
                    child: Text(
                      landmarkName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0, // Reduced font size
                      ),
                      maxLines: 1, // Ensure the text does not wrap
                      overflow: TextOverflow
                          .ellipsis, // Add ellipsis for overflowed text
                    ),
                  ),
                  SizedBox(
                      height: 8.0), // Reduced space between text and button
                  ElevatedButton(
                    onPressed: onVisitTap,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black, // Text color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0), // Reduced padding
                    ),
                    child: Text(
                      'Visit',
                      style: TextStyle(
                          fontSize:
                              14.0), // Reduced font size of the button text
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
