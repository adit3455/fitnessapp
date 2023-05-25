part of 'fetch_work_out_before_eighteen_bloc.dart';

abstract class FetchWorkOutBeforeEighteenEvent extends Equatable {
  const FetchWorkOutBeforeEighteenEvent();

  @override
  List<Object> get props => [];
}

class LoadBefore18 extends FetchWorkOutBeforeEighteenEvent {}

class UpdateBefore18 extends FetchWorkOutBeforeEighteenEvent {
  final WorkOutBeforeEighteenModel before18;

  const UpdateBefore18(this.before18);

  @override
  List<Object> get props => [before18];
}
