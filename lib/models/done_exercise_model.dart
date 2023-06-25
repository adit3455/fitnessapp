// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fitness_app/models/export_model.dart';

class DoneExerciseModel {
  final String date;
  final String duration;
  final double totalCalories;
  final int month;
  final int day;
  final List<ExerciseModel> accomodateExercises;

  DoneExerciseModel({
    required this.date,
    required this.duration,
    required this.totalCalories,
    required this.month,
    required this.day,
    required this.accomodateExercises,
  });

  DoneExerciseModel copyWith({
    String? date,
    String? duration,
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
      duration: map['duration'] as String,
      totalCalories: map['totalCalories'] as double,
      month: map['month'] as int,
      day: map['day'] as int,
      accomodateExercises: List<ExerciseModel>.from(
        (map['accomodateExercises'] as List<int>).map<ExerciseModel>(
          (x) => ExerciseModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoneExerciseModel.fromJson(String source) =>
      DoneExerciseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoneExerciseModel(date: $date, duration: $duration, totalCalories: $totalCalories, month: $month, day: $day, accomodateExercises: $accomodateExercises)';
  }

  @override
  bool operator ==(covariant DoneExerciseModel other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.duration == duration &&
        other.totalCalories == totalCalories &&
        other.month == month &&
        other.day == day &&
        listEquals(other.accomodateExercises, accomodateExercises);
  }

  @override
  int get hashCode {
    return date.hashCode ^
        duration.hashCode ^
        totalCalories.hashCode ^
        month.hashCode ^
        day.hashCode ^
        accomodateExercises.hashCode;
  }
}
