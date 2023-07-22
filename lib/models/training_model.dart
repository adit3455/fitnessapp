// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fitness_app/models/exercises_model.dart';
import 'package:isar/isar.dart';

part 'training_model.g.dart';

@Collection()
class TrainingModel {
  Id id;
  String name;
  final lExercises = IsarLinks<ExerciseModel>();

  TrainingModel({
    this.id = Isar.autoIncrement,
    required this.name,
  });

  @override
  bool operator ==(covariant TrainingModel other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
