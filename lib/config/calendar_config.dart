import 'package:equatable/equatable.dart';
import 'package:fitness_app/pages/main_pages/reports_page.dart';
import 'package:intl/intl.dart';

import '../models/done_exercise_model.dart';

class CalendarConfig extends Equatable {
  final List<DoneExerciseModel> l;
  const CalendarConfig({required this.l});

  DateTime stringToDateTime(String s) => DateFormat.yMd().parse(s);

  Map<DateTime, List<DoneExerciseModel>> get listDoneToMap {
    final Map<DateTime, List<DoneExerciseModel>> date = {};
    for (var i = 0; i < l.length; i++) {
      date[DateFormat.yMMMMEEEEd().parse(l[i].date)] =
          l.where((element) => element.date == l[i].date).toList();
    }
    return date;
  }

  List<ChartData> get lineChartSet {
    final List<ChartData> data = <ChartData>[];
    for (var i = 0; i < l.length; i++) {
      final date =
          DateFormat.MMMd().format(DateFormat.yMMMMEEEEd().parse(l[i].date));
      final totalCalories = l[i].totalCalories.toInt();
      final chart = ChartData(date, totalCalories);
      data.add(chart);
    }
    return data;
  }

  Map<String, dynamic> get allCardExercises {
    final exercises = l.fold(
        0,
        (previousValue, element) =>
            element.accomodateExercises.length + previousValue);
    final kcal = l.fold(
        0,
        (previousValue, element) =>
            element.totalCalories.toInt() + previousValue);
    final duration =
        l.fold(0, (previousValue, element) => element.duration + previousValue);
    String strDigits(int n) => n.toString().padLeft(2, '0');
    String hours(Duration d) => strDigits(d.inHours.remainder(24));
    String minutes(Duration d) => strDigits(d.inMinutes.remainder(60));
    String seconds(Duration d) => strDigits(d.inSeconds.remainder(60));
    return {
      "exercises": exercises,
      "kcal": kcal,
      "duration":
          "${hours(Duration(seconds: duration))}:${minutes(Duration(seconds: duration))}:${seconds(Duration(seconds: duration))}",
    };
  }

  @override
  List<Object?> get props => [l];
}
