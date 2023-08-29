part of 'reports_exercise_bloc.dart';

abstract class ReportsExerciseState extends Equatable {
  const ReportsExerciseState();

  @override
  List<Object?> get props => [];
}

class ReportsExerciseInitial extends ReportsExerciseState {}

class ReportsIsEmptyState extends ReportsExerciseState {
  @override
  List<Object?> get props => [];
}

class ReportsLoaded extends ReportsExerciseState {
  final List<DoneExerciseModel>? doneExerciseModel;
  final DateTime dateTimeNow;
  final Map<DateTime, List<DoneExerciseModel>> mapDone;
  const ReportsLoaded({
    required this.mapDone,
    this.doneExerciseModel,
    required this.dateTimeNow,
  });
  @override
  List<Object?> get props => [doneExerciseModel, dateTimeNow];

  ReportsLoaded copyWith({
    final List<DoneExerciseModel>? doneExerciseModel,
    final DateTime? dateTimeNow,
    final Map<DateTime, List<DoneExerciseModel>>? mapDone,
  }) {
    return ReportsLoaded(
        mapDone: mapDone ?? this.mapDone,
        dateTimeNow: dateTimeNow ?? this.dateTimeNow,
        doneExerciseModel: doneExerciseModel ?? this.doneExerciseModel);
  }
}

class ReportsExerciseError extends ReportsExerciseState {
  final String message;
  const ReportsExerciseError(this.message);
  @override
  List<Object> get props => [message];
}
