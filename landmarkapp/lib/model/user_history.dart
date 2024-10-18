class UserHistory {
  String? userEmail;
  List<VisitedPlaces>? visitedPlaces;

  UserHistory({this.userEmail, this.visitedPlaces});

  UserHistory.fromJson(Map<String, dynamic> json) {
    userEmail = json['userEmail'];
    if (json['visitedPlaces'] != null) {
      visitedPlaces = <VisitedPlaces>[];
      json['visitedPlaces'].forEach((v) {
        visitedPlaces!.add(VisitedPlaces.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userEmail'] = userEmail;
    if (visitedPlaces != null) {
      data['visitedPlaces'] = visitedPlaces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VisitedPlaces {
  String? placeName;
  String? placeImageLink;
  String? timestamp;

  VisitedPlaces({this.placeName, this.placeImageLink, this.timestamp});

  VisitedPlaces.fromJson(Map<String, dynamic> json) {
    placeName = json['placeName'];
    placeImageLink = json['placeImageLink'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['placeName'] = placeName;
    data['placeImageLink'] = placeImageLink;
    data['timestamp'] = timestamp;
    return data;
  }
}
