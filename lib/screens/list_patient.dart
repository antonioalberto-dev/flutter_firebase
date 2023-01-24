import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/controllers/paciente_controller.dart';
import 'package:crud_firebase/models/patient.dart';
import 'package:crud_firebase/screens/form_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class ListPatient extends StatefulWidget {
  const ListPatient({Key? key}) : super(key: key);

  @override
  State<ListPatient> createState() => _ListPatientState();
}

class _ListPatientState extends State<ListPatient> {
  final CollectionReference _patient =
      FirebaseFirestore.instance.collection("patients");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pacientes",
          style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: StreamBuilder(
              stream: _patient.snapshots(),
              builder: (context, AsyncSnapshot snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  );
                }
                if (snapshots.hasData) {
                  return ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot records =
                          snapshots.data!.docs[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: Slidable(
                          startActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  final patient = Patient(
                                    id: records.id,
                                    name: records["name"],
                                    years: records["years"],
                                    phone: records["phone"],
                                    diagnostic: records["diagnostic"],
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FormPatient(
                                        patient: patient,
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icons.edit_note_rounded,
                                backgroundColor: Colors.yellowAccent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  PatientController().onDelete(
                                    Patient(id: records.id),
                                  );
                                },
                                icon: Icons.delete_forever,
                                backgroundColor: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.purple[50],
                                borderRadius: BorderRadius.circular(5)),
                            child: ListTile(
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    height: 50,
                                    width: 50,
                                    child: Center(
                                      child: Text(
                                        records["name"][0],
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              title: Text(
                                records["name"],
                                style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  records["years"] == ''
                                      ? Text(
                                          "Idade não informada",
                                          style: GoogleFonts.ubuntu(
                                              color: Colors.black26),
                                        )
                                      : Text(
                                          records["years"].toString() == "1"
                                              ? "${records["years"].toString()} ano"
                                              : "${records["years"].toString()} anos",
                                          style: GoogleFonts.ubuntu(
                                              color: Colors.black54),
                                        ),
                                  records["phone"] == ''
                                      ? Text(
                                          "Diagnostico não informado",
                                          style: GoogleFonts.ubuntu(
                                              color: Colors.black54),
                                        )
                                      : Text(
                                          "${records["diagnostic"].toString()}",
                                          style: GoogleFonts.ubuntu(
                                              color: Colors.black54),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
