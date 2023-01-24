import 'package:crud_firebase/components/text_field_item.dart';
import 'package:crud_firebase/controllers/paciente_controller.dart';
import 'package:crud_firebase/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormPatient extends StatefulWidget {
  final Patient? patient;
  final index;

  FormPatient({this.patient, this.index});

  @override
  State<FormPatient> createState() => _FormPatientState();
}

class _FormPatientState extends State<FormPatient> {
  final _formKey = GlobalKey<FormState>();
  bool isEditingMode = false;
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearsController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController diagnosticController = TextEditingController();

  @override
  void initState() {
    if (widget.index != null) {
      idController.text = widget.patient!.id;
      nameController.text = widget.patient!.name;
      yearsController.text = widget.patient!.years;
      phoneController.text = widget.patient!.phone;
      diagnosticController.text = widget.patient!.diagnostic;
      isEditingMode = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isEditingMode == true
            ? Text("Editando")
            : Text("Cadastrando paciente"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldItem(
                labelText: "Nome",
                hinterText: null,
                controller: nameController,
                icon: Icons.personal_injury_rounded,
              ),
              TextFieldItem(
                labelText: "Idade",
                hinterText: null,
                controller: yearsController,
                icon: Icons.cookie_rounded,
              ),
              TextFieldItem(
                labelText: "Telefone",
                hinterText: null,
                controller: phoneController,
                icon: Icons.local_phone_rounded,
              ),
              TextFieldItem(
                labelText: "Diagnostico",
                hinterText: null,
                controller: diagnosticController,
                icon: Icons.text_snippet_rounded,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (isEditingMode == true) {
                      PatientController().onUpdate(Patient(
                        id: idController.text,
                        name: nameController.text,
                        years: yearsController.text,
                        phone: phoneController.text,
                        diagnostic: diagnosticController.text,
                      ));
                    } else {
                      PatientController().onCreate(Patient(
                        name: nameController.text,
                        years: yearsController.text,
                        phone: phoneController.text,
                        diagnostic: diagnosticController.text,
                      ));
                    }
                  }
                  Navigator.pop(context);
                },
                child: isEditingMode == true
                    ? Text("Atualizar", style: GoogleFonts.inter())
                    : Text("Salvar", style: GoogleFonts.inter()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
