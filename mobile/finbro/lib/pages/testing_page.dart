// ignore_for_file: prefer_const_constructors

import 'package:finbro/domain/User.dart';
import 'package:finbro/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {

  final UserService userService = UserService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = '';

  User createdUser = User(
      id: 18,
      name: 'monkey',
      surname: 'gaming',
      age: 4,
      username: 'MonkeyGaming',
      email: 'monkey@gmail.com',
      password: 'monkmonk');

  void _login() async {

    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        message = 'Please enter email and password';
      });
    }
    else {
      validateUserCredentials(email, password);
    }

  }

  void createUser(User user) async {

    try {
      var result = await userService.createUser(user);
      if (result is User) {
        message = 'hello, ${result.username}';
      }
      else if (result is String) {
        message = result;
      }
      setState(() {
        message;
      });
    }
    catch (e) {
      setState(() {
        message = 'Failed to log in: $e';
      });
    }

  }

  void getUser(int userId) async {

    try {
      var result = await userService.getUser(userId);
      if (result is User) {
        message = 'Hello\n${result.toString()}';
      }
      else if (result is String) {
        message = result;
      }
      setState(() {
        message;
      });
    }
    catch (e) {
      setState(() {
        message = "Failed to log in: $e";
      });
    }

  }

  void validateUserCredentials(String email, String password) async {

    try {
      var result = await userService.validateUserCredentials(email, password);
      if (result is User) {
        message = "Hello\n${result.toString()}";
      }
      else {
        message = result.success.toString();
      }
      setState(() {
        message;
      });
    }
    catch(e) {
      setState(() {
        message = "$e";
      });
    }

  }

  void updateUser(User user) async {

    try {
      var result = await userService.updateUser(user);
      if (result is User) {
        message = 'Hello\n${result.toString()}';
      }
      else if (result is String) {
        message = result;
      }
      setState(() {
        message;
      });
    }
    catch (e) {
      setState(() {
        message = "Failed to update user";
      });
    }

  }

  void deleteUser(User user) async {

    try {
      var result = await userService.deleteUser(user.id);
      if (result is String) {
        message = result;
      }
      setState(() {
        message;
      });
    }
    catch (e) {
      setState(() {
        message = "Failed to delete user";
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text("Log In"),
            ),
            SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}
