class BadHabitsModel {
  String? socialNorms;
  String? description;
  QuitSmoking? quitSmoking;

  BadHabitsModel({this.socialNorms, this.description, this.quitSmoking});

  BadHabitsModel.fromJson(Map<String, dynamic> json) {
    socialNorms = json['socialNorms'];
    description = json['description'];
    quitSmoking = json['quitSmoking'] != null
        ? QuitSmoking.fromJson(json['quitSmoking'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['socialNorms'] = socialNorms;
    data['description'] = description;
    if (quitSmoking != null) {
      data['quitSmoking'] = quitSmoking!.toJson();
    }
    return data;
  }
}

class QuitSmoking {
  String? third;
  List<String>? fourth;
  String? five;
  String? first;
  List<String>? second;

  QuitSmoking({this.third, this.fourth, this.five, this.first, this.second});

  QuitSmoking.fromJson(Map<String, dynamic> json) {
    third = json['third'];
    fourth = json['fourth'].cast<String>();
    five = json['five'];
    first = json['first'];
    second = json['second'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['third'] = third;
    data['fourth'] = fourth;
    data['five'] = five;
    data['first'] = first;
    data['second'] = second;
    return data;
  }
}
