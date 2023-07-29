import 'package:fitness_app/models/reminder_timer.dart';
import 'package:fitness_app/repository/isar_repo/base_isar_repo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/exercises_model.dart';
import '../../models/set_weekly_goal_model.dart';
import '../../models/training_model.dart';

class IsarSetReminder extends BaseIsarReporitories<ReminderTimerModel> {
  @override
  Future<void> deleteAllIsar(List<int> listTIsar) async {
    final isar = await db;

    await isar
        .writeTxn(() async => isar.reminderTimerModels.deleteAll(listTIsar));
  }

  @override
  Future<void> deleteByIndex(tModel) async {
    final isar = await db;

    await isar.writeTxn(() async => isar.reminderTimerModels.delete(tModel.id));
  }

  Future<void> updateIsar(String dateTime, ReminderTimerModel tModel) async {
    final isar = await db;

    final data =
        await isar.reminderTimerModels.where().idEqualTo(tModel.id).findFirst();

    data!.duration = dateTime;

    await isar.writeTxn(() async => await isar.reminderTimerModels.put(data));
  }

  @override
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([
        SetWeeklyGoalModelSchema,
        TrainingModelSchema,
        ExerciseModelSchema,
        ReminderTimerModelSchema
      ], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> saveIsar(tModel) async {
    final isar = await db;

    await isar
        .writeTxnSync(() async => isar.reminderTimerModels.putSync(tModel));
  }

  @override
  Future<List<ReminderTimerModel>> getAllIsar() async {
    final isar = await db;
    return await isar.reminderTimerModels.where().findAll();
  }
}
