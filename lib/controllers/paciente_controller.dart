import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/patient.dart';

final CollectionReference _patients =
    FirebaseFirestore.instance.collection("patients");

class PatientController {
  // add student
  Future onCreate(Patient patient) async {
    await _patients.doc().set(patient.addData());
  }

  // edit patient
  Future onUpdate(Patient patient) async {
    await _patients.doc(patient.id).update(patient.addData());
  }

  // remove patient
  Future onDelete(Patient patient) async {
    await _patients.doc(patient.id).delete();
  }
}
