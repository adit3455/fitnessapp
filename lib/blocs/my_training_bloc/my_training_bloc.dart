import 'package:fitness_app/models/exercises_model.dart';
import 'package:fitness_app/models/training_model.dart';
import 'package:fitness_app/repository/isar_repo/isar_my_training.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_training_event.dart';
part 'my_training_state.dart';

class MyTrainingBloc extends Bloc<MyTrainingEvent, MyTrainingState> {
  final IsarMyTraining _isarMyTraining;
  List<ExerciseModel> lAccomodate = <ExerciseModel>[];
  List<TrainingModel> lTrain = <TrainingModel>[];

  MyTrainingBloc({required IsarMyTraining isarMyTraining})
      : _isarMyTraining = isarMyTraining,
        super(MyTrainingLoading()) {
    on<MyTrainingStarted>((event, emit) async {
      emit(MyTrainingLoading());
      final data = await _isarMyTraining.getAllIsar();
      emit(MyTrainigGet(lTraining: data));
    });

    on<NavigateToAddExercise>((event, emit) {
      emit(AddExerciseState(lAccomodateAdd: lAccomodate));
    });

    on<NavigatorPopToGet>((event, emit) async {
      final data = await _isarMyTraining.getAllIsar();
      emit(MyTrainigGet(lTraining: data));
    });

    on<AddToAcomodateExerciseEvent>((event, emit) {
      lAccomodate.add(event.exerciseModel);
      emit(AddExerciseState(lAccomodateAdd: lAccomodate));
    });

    on<RemoveAccomodateExerciseEvent>((event, emit) {
      lAccomodate = List.from(lAccomodate);
      lAccomodate.remove(event.exerciseModel);

      emit(AddExerciseState(lAccomodateAdd: lAccomodate));
    });

    on<SaveTraining>((event, emit) async {
      final tModel = TrainingModel(name: event.name)
        ..lExercises.addAll(event.lExercises);

      await isarMyTraining.saveIsar(tModel);
      emit(MyTrainingLoading());
    });

    on<RemoveGetTraininng>((event, emit) async {
      emit(MyTrainingLoading());
      await isarMyTraining.deleteByIndex(event.tModel);
      final data = await isarMyTraining.getAllIsar();
      emit(MyTrainigGet(lTraining: data));
    });

    on<ChangeTrainingName>((event, emit) async {
      emit(MyTrainingLoading());

      await isarMyTraining.updateTrainingName(event.name, event.tModel);

      final data = await isarMyTraining.getAllIsar();
      final dataI = List.from(data).cast<TrainingModel>();
      emit(MyTrainigGet(lTraining: dataI));
      add(MyTrainingStarted());
    });
  }
}
