import 'package:crud_firebase/screens/list_patient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/item_menu.dart';
import 'form_patient.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        iconTheme: IconThemeData(
          color: Colors.blue[700],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue,
        child: ListView(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                "assets/2.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
              child: Text(
                "Serviços",
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            ItemMenu(
              router: FormPatient(),
              title: "Adicionar paciente",
              icon: Icons.add_reaction_rounded,
              color: Colors.black38,
            ),
            ItemMenu(
              router: const ListPatient(),
              title: "Meus pacientes",
              icon: Icons.personal_injury_rounded,
              color: Colors.black38,
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
