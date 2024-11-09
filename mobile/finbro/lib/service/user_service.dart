import 'dart:convert';

import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/User.dart';
import 'package:finbro/api/user_api.dart';

class UserService {

  final UserRepository _userRepository = UserRepository();

  // method to create new User
  Future<dynamic> createUser(User user) async {
    var response = await _userRepository.createUser(user);

    if (response['success'] == false) {
      return response['error']['details'];
    }
    else if (response['success'] == true) {
      return User.fromJson(response['data']);
    }
    else {
      return 'Unknown error occurred';
    }

  }

  // Method to fetch User
  Future<dynamic> getUser(int userId) async {

    var response = await _userRepository.fetchUser(userId);

    if (response['success'] == false) {
      return response['error']['details'];
    }
    else if (response['success'] == true) {
      return User.fromJson(response['data']);
    }
    else {
      return 'Unknown error occurred';
    }

  }

  // Method to validate user credentials
  Future<ApiResult> validateUserCredentials(String email, String password) async {

    var response = await _userRepository.validateUserCredentials(email, password);

    if (response['success'] == true) {
      var user = User.fromJson(response['data']['user']);
      return ApiResult.success(user);
    }
    else  {
      return ApiResult.failure('Invalid credentials');
    }

  }

  // Method to update user information
  Future<dynamic> updateUser(User user) async {

    var response = await _userRepository.updateUser(user);

    if (response['success'] == false) {
      return response['error']['details'];
    }
    else if (response['success'] == true) {
      return User.fromJson(response['data']);
    }
    else {
      return 'Unknown error occurred';
    }

  }

  // Method to delete a user
  Future<dynamic> deleteUser(int userId) async {

    var response = await _userRepository.deleteUser(userId);

    if (response['success'] == false) {
      return response['error']['details'];
    }
    else if (response['success'] == true) {
      return "User successfully deleted";
    }
    else {
      return "Unknown error occurred";
    }

  }

}