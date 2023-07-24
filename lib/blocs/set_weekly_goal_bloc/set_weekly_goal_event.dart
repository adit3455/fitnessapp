// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'set_weekly_goal_bloc.dart';

abstract class SetWeeklyGoalEvent extends Equatable {
  const SetWeeklyGoalEvent();

  @override
  List<Object> get props => [];
}

class SetWeeklyGoalStarted extends SetWeeklyGoalEvent {}

class SetWeeklyGoalSetup extends SetWeeklyGoalEvent {
  final String selectedDay;
  const SetWeeklyGoalSetup({required this.selectedDay});
}

class SaveWeeklyGoal extends SetWeeklyGoalEvent {
  final String daySet;
  const SaveWeeklyGoal({required this.daySet});

  @override
  List<Object> get props => [daySet];
}
