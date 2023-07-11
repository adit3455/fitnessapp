import 'package:fitness_app/models/isarmodel/student.dart';
import 'package:fitness_app/models/isarmodel/teacher.dart';
import 'package:isar/isar.dart';

part 'course.g.dart';

@Collection()
class Course {
  Id id = Isar.autoIncrement;
  late String title;

  @Backlink(to: "course")
  final teacher = IsarLink<Teacher>();
  @Backlink(to: "course")
  final student = IsarLink<Student>();
}
