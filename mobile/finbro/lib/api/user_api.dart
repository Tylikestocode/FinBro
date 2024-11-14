import 'dart:convert';

import 'package:finbro/domain/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final String apiUrl = 'https://finbro.yazeedmo.com/api/mobile/users';

  // Function to create a new User
  Future<Map<String, dynamic>> createUser(User user) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 409) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create User. Unknown error');
    }
  }

  // Function to fetch user by ID
  Future<Map<String, dynamic>> fetchUser(int userId) async {
    final response = await http.get(Uri.parse('$apiUrl/$userId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      return errorResponse;
    } else {
      throw Exception('Failed to load user');
    }
  }

  // Function to update user information
  Future<Map<String, dynamic>> updateUser(User user) async {
    final response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 409) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update User. Unknown error');
    }
  }

  // Function to get user by email and password
  Future<Map<String, dynamic>> validateUserCredentials(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/validate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 400) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to validate credentials. Unknown error: ${response.statusCode}');
    }
  }

  // Function to delete a user
  Future<Map<String, dynamic>> deleteUser(int userId) async {
    final response = await http.delete(Uri.parse('$apiUrl/$userId'));

    if (response.statusCode == 204 || response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      return errorResponse;
    } else {
      throw Exception('Failed to delete user');
    }
  }
}
