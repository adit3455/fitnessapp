import 'package:dartz/dartz.dart';
import 'package:fitness_app/models/done_exercise_model.dart';
import 'package:fitness_app/models/exercises_model.dart';
import 'package:fitness_app/repository/firebase_exercise_module.dart/base_firebase_exercise_modul.dart';

import '../../models/failure_model.dart';

class FirebaseExerciseModule extends BaseFirebaseExerciseModule {
  Future<void> sendDoneExercise(
      {required String date,
      required int duration,
      required double totalCalories,
      required List<ExerciseModel> accomodateExercises}) async {
    try {
      final List<Map<String, dynamic>> dataExercise =
          accomodateExercises.map((e) => e.toMap()).toList();

      await db
          .collection('userExercise')
          .doc('${fbAuth.currentUser?.uid}')
          .collection('dateExercise')
          .doc(super.date)
          .set({
        "date": date,
        "duration": duration,
        "month": int.parse(super.month),
        "day": int.parse(super.day),
        "totalCalories": totalCalories,
        "accomodateExercises": dataExercise
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Either<List<DoneExerciseModel>, FailureModel>>
      getDoneExercise() async {
    try {
      final snapshot = await db
          .collection('userExercise')
          .doc("${fbAuth.currentUser?.uid}")
          .collection('dateExercise')
          .get();
      final data = snapshot.docs
          .map((e) => DoneExerciseModel.fromMap(e.data()))
          .toList();
      if (data.isEmpty) {
        return Right(FailureModel(message: "Data not Exits"));
      }
      return Left(data);
    } catch (e) {
      return Right(FailureModel(message: e.toString()));
    }
  }

  Future<List<DoneExerciseModel>> getDoneExercise2() async {
    final snapshot = await db
        .collection('userExercise')
        .doc("${fbAuth.currentUser?.uid}")
        .collection('dateExercise')
        .get();
    final data =
        snapshot.docs.map((e) => DoneExerciseModel.fromMap(e.data())).toList();

    return data;
  }

  Future<Either<DoneExerciseModel, FailureModel>> getUserExercise() async {
    try {
      final snapshot = await db
          .collection('userExercise')
          .doc("${fbAuth.currentUser?.uid}")
          .collection('dateExercise')
          .doc(super.date)
          .get();

      final map = snapshot.data() as Map<String, dynamic>;
      return Left(DoneExerciseModel.fromMap(map));
    } catch (e) {
      return Right(FailureModel(message: e.toString()));
    }
  }

  Future<void> updateExercise(
      {required int duration,
      required double totalCalories,
      required List<Map<String, dynamic>> accomodateExercises}) async {
    try {
      await db
          .collection('userExercise')
          .doc('${fbAuth.currentUser?.uid}')
          .collection('dateExercise')
          .doc(super.date)
          .update({
        "duration": duration,
        "totalCalories": totalCalories,
        "accomodateExercises": accomodateExercises
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> handlingUpdateExercise(
      {required String date,
      required int duration,
      required double totalCalories,
      required List<ExerciseModel> accomodateExercises}) async {
    try {
      final snapshot = await db
          .collection('userExercise')
          .doc('${fbAuth.currentUser?.uid}')
          .collection('dateExercise')
          .doc(super.date)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final double totalCaloriesSnapshot = data['totalCalories'];
        final int durationSnapshot = data['duration'];
        final List accomodateExercisesSnapshot = data['accomodateExercises'];
        final fromMap = accomodateExercisesSnapshot
            .map((e) => ExerciseModel.fromMap(e))
            .toList();

        accomodateExercises.addAll(fromMap);
        final accomodateExercisesToMap =
            accomodateExercises.map((e) => e.toMap()).toList();

        await updateExercise(
            duration: duration + durationSnapshot,
            totalCalories: totalCalories + totalCaloriesSnapshot,
            accomodateExercises: accomodateExercisesToMap);
      } else if (!snapshot.exists) {
        await sendDoneExercise(
            date: date,
            duration: duration,
            totalCalories: totalCalories,
            accomodateExercises: accomodateExercises);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Either<List<ExerciseModel>, FailureModel>> getData() async {
    try {
      final snapshot =
          await db.collection('exercises').doc('allExercises').get();
      final data = snapshot.data() as Map<String, dynamic>;

      List inputMap = data['listExercise'];
      List<ExerciseModel> listOfExercise =
          inputMap.map((e) => ExerciseModel.fromMap(e)).toList();
      if (!snapshot.exists) {
        return Right(FailureModel(message: "Not found any of your data"));
      } else {
        return Left(listOfExercise);
      }
    } catch (e) {
      return Right(FailureModel(message: e.toString()));
    }
  }
}
