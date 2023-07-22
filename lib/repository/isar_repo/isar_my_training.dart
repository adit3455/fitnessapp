import 'package:fitness_app/models/training_model.dart';
import 'package:fitness_app/repository/isar_repo/base_isar_repo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/exercises_model.dart';

class IsarMyTraining extends BaseIsarReporitories<TrainingModel> {
  @override
  Future<void> saveIsar(tModel) async {
    final isar = await db;
    await isar.writeTxnSync(() async => isar.trainingModels.putSync(tModel));
  }

  @override
  Future<void> deleteByIndex(TrainingModel tModel) async {
    final isar = await db;
    final List<int> lExercises = [];
    tModel.lExercises.map((e) => lExercises.add(e.id)).toList();

    await isar.writeTxn(() async => isar.trainingModels.delete(tModel.id));
    await isar.writeTxn(() async => isar.exerciseModels.deleteAll(lExercises));
  }

  @override
  Future<List<TrainingModel>> getAllIsar() async {
    final isar = await db;
    return await isar.trainingModels.where().findAll();
  }

  @override
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([TrainingModelSchema, ExerciseModelSchema],
          inspector: true, directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> deleteAllIsar(List<int> listTIsar) async {
    final isar = await db;

    await isar.writeTxn(() async => isar.trainingModels.deleteAll(listTIsar));
  }

  Future<void> updateTrainingName(
      String name, TrainingModel trainingModel) async {
    final isar = await db;

    final data = await isar.trainingModels
        .where()
        .idEqualTo(trainingModel.id)
        .findFirst();
    data!.name = name;

    isar.writeTxn(() async => isar.trainingModels.put(data));
  }

  Future<void> clearlExercise() async {
    final isar = await db;
    await isar.writeTxn(() async => isar.exerciseModels.clear());
  }
}
