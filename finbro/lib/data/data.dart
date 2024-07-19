class Credentials {
  final String email;
  final String name;
  final String surname;
  final String password;
  final int age;

  Credentials(
      {required this.email,
      required this.name,
      required this.surname,
      required this.password,
      required this.age});

  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials(
        email: json['email'],
        name: json['name'],
        surname: json['surname'],
        password: json['password'],
        age: json['age']);
  }
}
