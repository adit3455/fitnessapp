part of 'fetch_bad_habit_bloc.dart';

abstract class FetchBadHabitEvent extends Equatable {
  const FetchBadHabitEvent();

  @override
  List<Object> get props => [];
}

class LoadBadHabit extends FetchBadHabitEvent {}

class UpdateBadHabit extends FetchBadHabitEvent {
  final BadHabitsModel badHabitsModel;

  const UpdateBadHabit(this.badHabitsModel);

  @override
  List<Object> get props => [badHabitsModel];
}
