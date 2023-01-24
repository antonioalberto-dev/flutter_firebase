class Patient {
  final id, name, years, phone, diagnostic;

  Patient({
    this.id,
    this.name,
    this.years,
    this.phone,
    this.diagnostic,
  });

  Map<String, dynamic> addData() {
    return {
      'name': name,
      'years': years,
      'phone': phone,
      'diagnostic': diagnostic,
    };
  }
}
