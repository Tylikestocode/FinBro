import 'dart:convert';

import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/user.dart';
import 'package:finbro/api/user_api.dart';
import 'package:finbro/util/session.dart';

class UserService {
  final UserRepository _userRepository = UserRepository();

  // method to create new User
  Future<ApiResult> createUser(User user) async {
    var response = await _userRepository.createUser(user);

    print('=====================================================${response}');

    if (response['success'] == true) {
      var user = User.fromJson(response['data']);
      Session.getInstance(currentUser: user);
      return ApiResult.success(user);
    } else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    } else {
      return ApiResult.failure('Unknown Error');
    }

  }

  // Method to fetch User
  Future<dynamic> getUser(int userId) async {
    var response = await _userRepository.fetchUser(userId);

    if (response['success'] == false) {
      return response['error']['details'];
    } else if (response['success'] == true) {
      return User.fromJson(response['data']);
    } else {
      return 'Unknown error occurred';
    }
  }

  // Method to validate user credentials
  Future<ApiResult> validateUserCredentials(
      String email, String password) async {
    var response =
        await _userRepository.validateUserCredentials(email, password);

    print('=================================================${response}');

    if (response['success'] == true) {
      var user = User.fromJson(response['data']['user']);
      Session.getInstance(currentUser: user);
      return ApiResult.success(user);
    } else if (response['success'] == false) {
      return ApiResult.failure('Incorrect Email or password');
    }
    else {
      return ApiResult.failure('Unknown Error');
    }

  }

  // Method to update user information
  Future<ApiResult> updateUser(User user) async {
    var response = await _userRepository.updateUser(user);

    if (response['success'] == true) {
      var user = User.fromJson(response['data']['user']);
      Session.getInstance().currentUser = user;
      return ApiResult.success(user);
    } else if (response['success'] == true) {
      return ApiResult.failure(response['error']['details']);
    } else {
      return ApiResult.failure('Unknown Error');
    }
  }

  // Method to delete a user
  Future<dynamic> deleteUser(int userId) async {
    var response = await _userRepository.deleteUser(userId);

    if (response['success'] == false) {
      return response['error']['details'];
    } else if (response['success'] == true) {
      return "User successfully deleted";
    } else {
      return "Unknown error occurred";
    }
  }
}
