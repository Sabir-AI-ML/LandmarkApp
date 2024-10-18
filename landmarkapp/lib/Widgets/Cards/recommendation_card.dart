import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  final String imagePath;
  final String landmarkName;
  final VoidCallback onVisitTap;
  final String reason;

  const RecommendationCard({
    super.key,
    required this.imagePath,
    required this.landmarkName,
    required this.onVisitTap,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            imagePath,
            height: 200,
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    landmarkName,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow
                        .ellipsis, // Add ellipsis when text is too long
                    softWrap: false, // Prevent text from wrapping to a new line
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton.icon(
                  icon: const Icon(Icons.location_on),
                  label: const Text('Visit'),
                  onPressed: onVisitTap,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              reason,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
