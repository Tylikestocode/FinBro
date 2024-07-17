class User {
  String name;
  String surname;
  int age;
  String email;

  User(this.name, this.surname, this.age, this.email);

  String getName() {
    return name;
  }

  String getSurname() {
    return surname;
  }

  int getAge() {
    return age;
  }

  String getEmail() {
    return email;
  }
}
