class User {
  final int? id;
  String? name;
  String? surname;
  int? age;
  String username;
  String email;
  String password;

  User(
      {this.id,
      this.name,
      this.surname,
      this.age,
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
    return 'User'
        '{id: $id,\n'
        'name: $name,\n'
        'surname: $surname,\n'
        'age: $age,\n'
        'username: $username,\n'
        'email: $email,\n'
        'password: $password}\n';
  }
}
