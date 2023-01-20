class Student {
  final id, name, email;

  Student({required this.id, required this.name, this.email});

  Map<String, dynamic> addData() {
    return {'name': name, 'email': email};
  }
}
