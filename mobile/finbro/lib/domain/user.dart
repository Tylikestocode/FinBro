class User {
  final int id;
  final String name;
  final String surname;
  final int age;
  final String username;
  final String email;
  final String password;

  User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.age,
      required this.username,
      required this.email,
      required this.password});

  // Factory constructor for creating a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        surname: json['surname'],
        age: json['age'],
        username: json['username'],
        email: json['email'],
        password: json['password']);
  }

  // Method for converting a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'age': age,
      'username': username,
      'email': email,
      'password': password
    };
  }

  @override
  String toString() {
    return 'User{id: $id,\nname: $name,\nsurname: $surname,\nage: $age,\nusername: $username,\nemail: $email,\npassword: $password}\n';
  }
}
