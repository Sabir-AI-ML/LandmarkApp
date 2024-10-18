class ResultModel {
  String? landmarkName;
  String? confidenceScore;
  String? landmarkInformation;
  List<dynamic>? nearbyLandmarks;

  ResultModel(
      {this.landmarkName,
      this.confidenceScore,
      this.landmarkInformation,
      this.nearbyLandmarks});

  ResultModel.fromJson(Map<String, dynamic> json) {
    landmarkName = json['Landmark Name'];
    confidenceScore = json['Confidence Score'];
    landmarkInformation = json['Landmark Information'];
    nearbyLandmarks = json['Nearby Landmarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Landmark Name'] = landmarkName;
    data['Confidence Score'] = confidenceScore;
    data['Landmark Information'] = landmarkInformation;
    data['Nearby Landmarks'] = nearbyLandmarks;
    return data;
  }
}
