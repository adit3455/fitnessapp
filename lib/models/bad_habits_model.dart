// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:equatable/equatable.dart';

// class BadHabitsModel extends Equatable {
//   final String? description;
//   final String? socialNorms;
//   final QuitSmokingModel? quitSmokingModel;
//   const BadHabitsModel({
//     this.description,
//     this.socialNorms,
//     this.quitSmokingModel,
//   });

//   factory BadHabitsModel.fromJson(Map<String, dynamic> json) {
//     return BadHabitsModel(
//         description: json['description'],
//         socialNorms: json['socialNorms'],
//         quitSmokingModel: json['quitSmoking']);
//   }

//   @override
//   List<Object?> get props => [description, socialNorms, quitSmokingModel];
// }

// class QuitSmokingModel extends Equatable {
//   final String? first;
//   final List<String>? second;
//   final String? third;
//   final List<String>? fourth;
//   final String? five;
//   const QuitSmokingModel({
//     this.first,
//     this.second,
//     this.third,
//     this.fourth,
//     this.five,
//   });

//   factory QuitSmokingModel.fromJson(Map<String, dynamic> json) {
//     return QuitSmokingModel(
//         first: json['first'],
//         second: json['second'],
//         third: json['third'],
//         fourth: json['fourth'],
//         five: json['five']);
//   }

//   @override
//   List<Object?> get props => [first, second, third, fourth, five];
// }

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