// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';
part 'set_weekly_goal_model.g.dart';

@Collection()
class SetWeeklyGoalModel {
  String daySet;
  final Id id;
  SetWeeklyGoalModel({required this.daySet, this.id = Isar.autoIncrement});

  @override
  bool operator ==(covariant SetWeeklyGoalModel other) {
    if (identical(this, other)) return true;

    return other.daySet == daySet && other.id == id;
  }

  @override
  int get hashCode => daySet.hashCode ^ id.hashCode;
}
