// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'set_weekly_goal_bloc.dart';

abstract class SetWeeklyGoalState extends Equatable {
  const SetWeeklyGoalState();

  @override
  List<Object?> get props => [];
}

class SetWeeklyGoalLoading extends SetWeeklyGoalState {}

class SetWeeklyGoalSetWeekState extends SetWeeklyGoalState {
  final String? selectedDay;
  const SetWeeklyGoalSetWeekState({this.selectedDay});
  @override
  List<Object?> get props => [selectedDay];

  SetWeeklyGoalSetWeekState copyWith({
    String? selectedDay,
  }) {
    return SetWeeklyGoalSetWeekState(
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}

class SetWeeklyErrorMessage extends SetWeeklyGoalState {
  final String message;
  const SetWeeklyErrorMessage({required this.message});
  @override
  List<Object> get props => [message];
}

class SetWeeklyCalendar extends SetWeeklyGoalState {
  final Map<DateTime, List<DoneExerciseModel>> mapDone;
  final int eDoneThisWeek;
  final int totalDaySet;

  const SetWeeklyCalendar({
    required this.mapDone,
    required this.eDoneThisWeek,
    required this.totalDaySet,
  });

  @override
  List<Object?> get props => [mapDone];
}
