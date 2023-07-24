import 'package:fitness_app/models/set_weekly_goal_model.dart';
import 'package:fitness_app/repository/isar_repo/base_isar_repo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarSetWeekly extends BaseIsarReporitories<SetWeeklyGoalModel> {
  @override
  Future<void> deleteAllIsar(List<int> listTIsar) async {
    final isar = await db;

    await isar
        .writeTxn(() async => isar.setWeeklyGoalModels.deleteAll(listTIsar));
  }

  @override
  Future<void> deleteByIndex(SetWeeklyGoalModel tModel) async {
    final isar = await db;

    await isar.writeTxn(() async => isar.setWeeklyGoalModels.delete(tModel.id));
  }

  @override
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([SetWeeklyGoalModelSchema], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> saveIsar(SetWeeklyGoalModel tModel) async {
    final isar = await db;

    await isar
        .writeTxnSync(() async => isar.setWeeklyGoalModels.putSync(tModel));
  }

  @override
  Future<List<SetWeeklyGoalModel>> getAllIsar() async {
    final isar = await db;
    return await isar.setWeeklyGoalModels.where().findAll();
  }
}
