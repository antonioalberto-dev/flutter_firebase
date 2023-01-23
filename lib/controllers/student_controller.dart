import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/student.dart';

final CollectionReference _students =
    FirebaseFirestore.instance.collection("students");

class StudentController {
  // add student
  Future onCreate(Student student) async {
    await _students.doc().set(student.addData());
  }

  // edit student
  Future onUpdate(Student student) async {
    await _students.doc(student.id).update(student.addData());
  }

  // remove student
  Future onDelete(Student student) async {
    await _students.doc(student.id).delete();
  }
}
