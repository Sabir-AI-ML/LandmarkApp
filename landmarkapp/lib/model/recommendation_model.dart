class RecommendationModel {
  List<Recommendation>? recommendation;

  RecommendationModel({this.recommendation});

  RecommendationModel.fromJson(Map<String, dynamic> json) {
    if (json['recommendation'] != null) {
      recommendation = <Recommendation>[];
      json['recommendation'].forEach((v) {
        recommendation!.add(Recommendation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recommendation != null) {
      data['recommendation'] = recommendation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recommendation {
  String? landmark;
  String? score;
  String? reason;
  String? imageLink;
  String? locationLink;

  Recommendation(
      {this.landmark,
      this.score,
      this.reason,
      this.imageLink,
      this.locationLink});

  Recommendation.fromJson(Map<String, dynamic> json) {
    landmark = json['landmark'];
    score = json['score'];
    reason = json['reason'];
    imageLink = json['image_link'];
    locationLink = json['location_link'];
  }

  get landmarkLocation => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['landmark'] = landmark;
    data['score'] = score;
    data['reason'] = reason;
    data['image_link'] = imageLink;
    data['location_link'] = locationLink;
    return data;
  }
}
