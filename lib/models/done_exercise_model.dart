import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:fitness_app/models/export_model.dart';

class DoneExerciseModel extends Equatable {
  final String date;
  final int duration;
  final double totalCalories;
  final int month;
  final int day;
  final List<ExerciseModel> accomodateExercises;
  const DoneExerciseModel({
    required this.date,
    required this.duration,
    required this.totalCalories,
    required this.month,
    required this.day,
    required this.accomodateExercises,
  });

  DoneExerciseModel copyWith({
    String? date,
    int? duration,
    double? totalCalories,
    int? month,
    int? day,
    List<ExerciseModel>? accomodateExercises,
  }) {
    return DoneExerciseModel(
      date: date ?? this.date,
      duration: duration ?? this.duration,
      totalCalories: totalCalories ?? this.totalCalories,
      month: month ?? this.month,
      day: day ?? this.day,
      accomodateExercises: accomodateExercises ?? this.accomodateExercises,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'duration': duration,
      'totalCalories': totalCalories,
      'month': month,
      'day': day,
      'accomodateExercises': accomodateExercises.map((x) => x.toMap()).toList(),
    };
  }

  factory DoneExerciseModel.fromMap(Map<String, dynamic> map) {
    return DoneExerciseModel(
      date: map['date'] as String,
      duration: map['duration'] as int,
      totalCalories: map['totalCalories'] as double,
      month: map['month'] as int,
      day: map['day'] as int,
      accomodateExercises: List<ExerciseModel>.from(
        (map['accomodateExercises'] as List).map<ExerciseModel>(
          (x) => ExerciseModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoneExerciseModel.fromJson(String source) =>
      DoneExerciseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      date,
      duration,
      totalCalories,
      month,
      day,
      accomodateExercises,
    ];
  }
}
