import 'dart:async';

import 'package:fitness_app/models/export_model.dart';
import 'package:fitness_app/repository/firebase_service/workout_before_18_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_work_out_before_eighteen_event.dart';
part 'fetch_work_out_before_eighteen_state.dart';

class FetchWorkOutBeforeEighteenBloc extends Bloc<
    FetchWorkOutBeforeEighteenEvent, FetchWorkOutBeforeEighteenState> {
  final WorkoutBeforeEighteenService _beforeEighteenService;
  StreamSubscription? _before18Subscription;
  FetchWorkOutBeforeEighteenBloc(
      {required WorkoutBeforeEighteenService beforeEighteenService})
      : _beforeEighteenService = beforeEighteenService,
        super(Before18Loading()) {
    on<LoadBefore18>((event, emit) {
      try {
        _before18Subscription?.cancel();
        _before18Subscription =
            _beforeEighteenService.getData().asStream().listen((before18) {
          before18.fold((l) => add(UpdateBefore18(l)),
              (r) => emit(Before18Error(r.message)));
        });
      } catch (e) {
        emit(Before18Error(e.toString()));
      }
    });
    on<UpdateBefore18>((event, emit) {
      emit(Before18Loaded(event.before18));
    });
  }
}
