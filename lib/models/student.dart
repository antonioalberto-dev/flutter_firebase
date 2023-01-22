class Student {
  final id, name, email;

  Student({
    this.id,
    this.name,
    this.email,
  });

  Map<String, dynamic> addData() {
    return {'name': name, 'email': email};
  }
}
