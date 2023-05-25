class WorkOutBeforeEighteenModel {
  List<String>? bennefitBullet;
  String? description;

  WorkOutBeforeEighteenModel({this.bennefitBullet, this.description});

  WorkOutBeforeEighteenModel.fromJson(Map<String, dynamic> json) {
    bennefitBullet = json['bennefitBullet'].cast<String>();
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bennefitBullet'] = bennefitBullet;
    data['description'] = description;
    return data;
  }
}
