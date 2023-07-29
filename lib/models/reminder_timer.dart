// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'reminder_timer.g.dart';

@Collection()
class ReminderTimerModel {
  Id id;
  String duration;
  ReminderTimerModel({this.id = Isar.autoIncrement, required this.duration});
}
