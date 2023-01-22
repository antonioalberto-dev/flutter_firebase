import 'package:crud_firebase/components/text_field_item.dart';
import 'package:crud_firebase/controllers/student_controller.dart';
import 'package:crud_firebase/models/student.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormStudent extends StatefulWidget {
  const FormStudent({Key? key}) : super(key: key);

  @override
  State<FormStudent> createState() => _FormStudentState();
}

class _FormStudentState extends State<FormStudent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Estudante"),
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
              ),
              TextFieldItem(
                labelText: "Email",
                hinterText: null,
                controller: emailController,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    StudentController().onCreate(
                      Student(name: nameController.text, email: emailController.text)
                    );
                  }
                  Navigator.pop(context);
                },
                child: Text("Salvar", style: GoogleFonts.inter()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
