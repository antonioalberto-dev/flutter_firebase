import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

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
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: StreamBuilder(
                  stream: _student.snapshots(),
                  builder: (context, AsyncSnapshot snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
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
                          return Slidable(
                            startActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {},
                                  icon: Icons.call,
                                  backgroundColor: Colors.green,
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
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
                              subtitle: Text(
                                records["email"],
                                style: GoogleFonts.inter(),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
