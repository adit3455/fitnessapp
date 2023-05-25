part of 'fetch_work_out_before_eighteen_bloc.dart';

abstract class FetchWorkOutBeforeEighteenState extends Equatable {
  const FetchWorkOutBeforeEighteenState();

  @override
  List<Object> get props => [];
}

class Before18Loading extends FetchWorkOutBeforeEighteenState {}

class Before18Loaded extends FetchWorkOutBeforeEighteenState {
  final WorkOutBeforeEighteenModel before18model;
  const Before18Loaded(this.before18model);

  @override
  List<Object> get props => [before18model];
}

class Before18Error extends FetchWorkOutBeforeEighteenState {
  final String error;
  const Before18Error(this.error);
  @override
  List<Object> get props => [error];
}
