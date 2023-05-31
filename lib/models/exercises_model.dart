// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ExerciseModel extends Equatable {
  final String name;
  final String instructions;
  final String image;
  final String? duration;
  final double calories;
  final String dificulities;
  final String type;

  const ExerciseModel({
    required this.name,
    required this.instructions,
    required this.image,
    this.duration = '60.00',
    required this.calories,
    required this.dificulities,
    required this.type,
  });

  ExerciseModel copyWith({
    String? name,
    String? instructions,
    String? image,
    String? duration,
    double? calories,
    String? dificulities,
    String? type,
  }) {
    return ExerciseModel(
      name: name ?? this.name,
      instructions: instructions ?? this.instructions,
      image: image ?? this.image,
      duration: duration ?? this.duration,
      calories: calories ?? this.calories,
      dificulities: dificulities ?? this.dificulities,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'instructions': instructions,
      'image': image,
      'duration': duration,
      'calories': calories,
      'dificulities': dificulities,
      'type': type,
    };
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      name: map['name'] as String,
      instructions: map['instructions'] as String,
      image: map['image'] as String,
      duration: map['duration'] != null ? map['duration'] as String : null,
      calories: map['calories'] as double,
      dificulities: map['dificulities'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseModel.fromJson(String source) =>
      ExerciseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      name,
      instructions,
      image,
      duration,
      calories,
      dificulities,
      type,
    ];
  }
}
