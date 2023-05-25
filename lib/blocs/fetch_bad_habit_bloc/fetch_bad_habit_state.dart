part of 'fetch_bad_habit_bloc.dart';

abstract class FetchBadHabitState extends Equatable {
  const FetchBadHabitState();

  @override
  List<Object> get props => [];
}

class BadHabitLoading extends FetchBadHabitState {}

class BadHabitLoaded extends FetchBadHabitState {
  final BadHabitsModel badHabitsModel;
  const BadHabitLoaded(this.badHabitsModel);
  @override
  List<Object> get props => [badHabitsModel];
}

class BadHabitError extends FetchBadHabitState {
  final String message;
  const BadHabitError(this.message);

  @override
  List<Object> get props => [message];
}
