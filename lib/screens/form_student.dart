import 'package:crud_firebase/components/text_field_item.dart';
import 'package:crud_firebase/controllers/student_controller.dart';
import 'package:crud_firebase/models/student.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormStudent extends StatefulWidget {
  final Student? student;
  final index;

  FormStudent({this.student, this.index});

  @override
  State<FormStudent> createState() => _FormStudentState();
}

class _FormStudentState extends State<FormStudent> {
  final _formKey = GlobalKey<FormState>();
  bool isEditingMode = false;
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    if (widget.index != null) {
      idController.text = widget.student!.id;
      nameController.text = widget.student!.name;
      emailController.text = widget.student!.email;
      isEditingMode = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isEditingMode == true
            ? Text("Editando registro")
            : Text("Cadastrando estudante"),
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
                    if (isEditingMode == true) {
                      StudentController().onUpdate(Student(
                        id: idController.text,
                        name: nameController.text,
                        email: emailController.text,
                      ));
                    } else {
                      StudentController().onCreate(Student(
                        name: nameController,
                        email: emailController,
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
