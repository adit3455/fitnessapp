part of 'reports_exercise_bloc.dart';

abstract class ReportsExerciseEvent extends Equatable {
  const ReportsExerciseEvent();

  @override
  List<Object> get props => [];
}

class LoadExerciseReports extends ReportsExerciseEvent {}

class UpdateExerciseReports extends ReportsExerciseEvent {
  final List<DoneExerciseModel> doneExerciseModel;
  const UpdateExerciseReports({required this.doneExerciseModel});
  @override
  List<Object> get props => [doneExerciseModel];
}
