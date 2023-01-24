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
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(20),
              child: Text(
                "Clinica Orto",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "Serviços",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FormPatient()),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.sick,
                  ),
                  iconColor: Colors.black,
                  titleTextStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  title: const Text(
                    "Adicionar paciente",
                  ),
                ),
              ),
            ),
            InkWell(
              // onTap: () {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => FormStudent()),
              //   );
              // },
              child: Container(
                margin: const EdgeInsets.only(left: 10, bottom: 2),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.south_america_outlined,
                  ),
                  iconColor: Colors.black,
                  titleTextStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  title: Text(
                    "Conheça mais sobre nós",
                  ),
                ),
              ),
            ),
          ],
        ),
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
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Slidable(
                          startActionPane: ActionPane(
                            motion: StretchMotion(),
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
                            motion: StretchMotion(),
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
                            margin: EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5)),
                            child: ListTile(
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.account_circle,
                                    size: 35,
                                    color: Colors.purple,
                                  ),
                                ],
                              ),
                              title: Text(
                                records["name"],
                                style: GoogleFonts.inter(
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
                                          style: GoogleFonts.inter(
                                              color: Colors.black26),
                                        )
                                      : Text(
                                          "${records["years"].toString()} anos",
                                          style: GoogleFonts.inter(),
                                        ),
                                  records["phone"] == ''
                                      ? Text(
                                          "Telefone não informado",
                                          style: GoogleFonts.inter(
                                              color: Colors.black26),
                                        )
                                      : Text(
                                          "${records["phone"].toString()}",
                                          style: GoogleFonts.inter(),
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
