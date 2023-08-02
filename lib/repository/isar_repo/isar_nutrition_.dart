import 'package:fitness_app/models/export_model.dart';
import 'package:fitness_app/repository/isar_repo/base_isar_repo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/reminder_timer.dart';
import '../../models/set_weekly_goal_model.dart';
import '../../models/training_model.dart';

class IsarNutrition extends BaseIsarReporitories<FoodModel> {
  @override
  Future<void> deleteAllIsar(List<int> listTIsar) async {
    final isar = await db;

    await isar.writeTxn(() async => await isar.foodModels.deleteAll(listTIsar));
  }

  @override
  Future<void> deleteByIndex(tModel) async {
    final isar = await db;
    await isar.writeTxn(() async => await isar.foodModels.delete(tModel.id));
  }

  @override
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([
        SetWeeklyGoalModelSchema,
        TrainingModelSchema,
        ExerciseModelSchema,
        ReminderTimerModelSchema,
        FoodModelSchema
      ], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> saveIsar(tModel) async {
    final isar = await db;

    await isar.writeTxnSync(() async => isar.foodModels.putSync(tModel));
  }

  @override
  Future<List<FoodModel>> getAllIsar() async {
    final isar = await db;

    return await isar.foodModels.where().findAll();
  }
}
