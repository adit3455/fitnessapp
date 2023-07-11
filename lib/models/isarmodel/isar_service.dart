import 'package:fitness_app/models/isarmodel/student.dart';
import 'package:fitness_app/models/isarmodel/teacher.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'course.dart';

class IsarService {
  late Future<Isar> db;
  IsarService() {
    db = openDb();
  }

  Future<void> saveCourse(Course newCourse) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.courses).putSync(newCourse);
  }

  Future<void> saveStudent(Student newStudent) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.students).putSync(newStudent);
  }

  Future<void> saveTeacher(Teacher newTeacher) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.teachers).putSync(newTeacher);
  }

  Future<List<Course>> getAllCourses() async {
    final isar = await db;
    return await isar.courses.where().findAll();
  }

  Stream<List<Course>> listenAllCourses() async* {
    final isar = await db;
    yield* isar.courses.where().watch(fireImmediately: true);
  }

  Future<List<Student>> getStudentsFor() async {
    throw UnimplementedError();
  }

  Future<Teacher?> getTeacherFor(Course course) {
    throw UnimplementedError();
  }

  Future<Isar> openDb() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([CourseSchema, StudentSchema, TeacherSchema],
          inspector: true, directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }
}
