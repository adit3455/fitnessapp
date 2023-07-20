// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fitness_app/models/exercises_model.dart';
import 'package:isar/isar.dart';

part 'training_model.g.dart';

@Collection()
class TrainingModel {
  final Id id;
  final String name;
  final lExercises = IsarLinks<ExerciseModel>();

  TrainingModel({
    this.id = Isar.autoIncrement,
    required this.name,
  });

  TrainingModel copyWith({
    String? name,
  }) {
    return TrainingModel(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory TrainingModel.fromMap(Map<String, dynamic> map) {
    return TrainingModel(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingModel.fromJson(String source) =>
      TrainingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TrainingModel(name: $name)';

  @override
  bool operator ==(covariant TrainingModel other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
