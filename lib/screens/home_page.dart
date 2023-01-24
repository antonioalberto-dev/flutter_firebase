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
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
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
            ItemMenu(
              router: FormPatient(),
              title: "Adicionar paciente",
              icon: Icons.add_reaction_rounded,
              color: Color.fromRGBO(144, 202, 249, 1),
            ),
            ItemMenu(
              router: const ListPatient(),
              title: "Meus pacientes",
              icon: Icons.personal_injury_rounded,
              color: Color.fromRGBO(225, 190, 231, 1),
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
