import 'package:fitness_app/models/exercises_model.dart';

class ExerciseConfig {
  String exerciseTypeChanger(String type) {
    if (type == 'lbworkout') {
      return 'Lower Body Workout';
    }
    if (type == 'ubworkout') {
      return 'Upper Body Workout';
    } else {
      return 'Full Body Workout';
    }
  }

  List<ExerciseModel> listFiltered(
      List<ExerciseModel> list, ExerciseModel exercise) {
    final filteredType =
        list.where((element) => element.type == exercise.type).toList();
    filteredType.removeWhere((element) => element.name == exercise.name);
    filteredType.shuffle();
    return filteredType;
  }

  List<ExerciseModel> listByTyping(List<ExerciseModel> list, String type) =>
      list.where((element) => element.type == type).toList();

  int sumList(List<ExerciseModel> list) => list.fold(
      0, (previousValue, element) => previousValue + element.calories.toInt());

  List<ExerciseModel> randomTypeList(List<ExerciseModel> list, String type) {
    final filteredType = list.where((element) => element.type == type).toList();
    filteredType.shuffle();
    return filteredType;
  }

  List<ExerciseModel> startExerciseList(List<ExerciseModel> list) {
    List<ExerciseModel> lower =
        randomTypeList(list, 'lbworkout').sublist(0, 4).toList();
    List<ExerciseModel> full =
        randomTypeList(list, 'fbworkout').sublist(0, 6).toList();
    List<ExerciseModel> upper =
        randomTypeList(list, 'ubworkout').sublist(0, 3).toList();

    List<ExerciseModel> result = upper
      ..addAll(full)
      ..addAll(lower);

    return result;
  }

  int subStringToInt(String s) {
    return int.parse(s.substring(0, 2));
  }

  Duration durationConverter(String s) => Duration(seconds: subStringToInt(s));

  int durationStarter(List<ExerciseModel> exercise) {
    int seconds = exercise.fold(
        0,
        (previousValue, element) =>
            previousValue + subStringToInt(element.duration.toString()));
    return Duration(seconds: seconds).inMinutes;
  }
}
