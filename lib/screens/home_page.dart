import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/controllers/student_controller.dart';
import 'package:crud_firebase/models/student.dart';
import 'package:crud_firebase/screens/form_student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _student =
      FirebaseFirestore.instance.collection("students");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alunos",
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
                "Meus alunos",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FormStudent()),
                );
              },
              child: ListTile(
                leading: const Icon(
                  Icons.supervised_user_circle_rounded,
                ),
                iconColor: Colors.black,
                titleTextStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, color: Colors.black),
                title: Text(
                  "Adicionar aluno",
                ),
              ),
            ),
            InkWell(
              // onTap: () {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => FormStudent()),
              //   );
              // },
              child: ListTile(
                leading: const Icon(
                  Icons.south_america_outlined,
                ),
                iconColor: Colors.black,
                titleTextStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, color: Colors.black),
                title: Text(
                  "Sobre",
                  // style: GoogleFonts.inter(fontSize: 14, color: Colors.purple),
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
              stream: _student.snapshots(),
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
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Slidable(
                          startActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  final student = Student(
                                    id: records.id,
                                    name: records["name"],
                                    email: records["email"],
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FormStudent(
                                        student: student,
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
                                  StudentController().onDelete(
                                    Student(id: records.id),
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
                              subtitle: records["email"] == ''
                                  ? Text(
                                      "Email não informado",
                                      style: GoogleFonts.inter(
                                          color: Colors.black26),
                                    )
                                  : Text(
                                      records["email"],
                                      style: GoogleFonts.inter(),
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
