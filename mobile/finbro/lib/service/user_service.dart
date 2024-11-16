import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/user.dart';
import 'package:finbro/api/user_api.dart';
import 'package:finbro/service/shared_prefs_service.dart';
import 'package:finbro/util/session.dart';

class UserService {
  final UserAPI _userAPI = UserAPI();
  final SharedPrefsService _sharedPrefsService = SharedPrefsService();

  // Create User
  Future<ApiResult> createUser(User user) async {
    var response = await _userAPI.createUser(user);

    if (response['success'] == true) {
      var user = User.fromJson(response['data']);
      _sharedPrefsService.saveCurrentUserId(user.id!);
      return ApiResult.success(user);
    } else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    } else {
      return ApiResult.failure('Unknown Error');
    }
  }

  // Get User by id
  Future<ApiResult> getUserById(int userId) async {
    var response = await _userAPI.getUserById(userId);

    if (response['success'] == true) {
      var user = User.fromJson(response['data']);
      return ApiResult.success(user);
    } else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    } else {
      return ApiResult.failure('Unknown Error');
    }
  }

  // Get User by username
  Future<ApiResult> getUserByUsername(String username) async {
    var response = await _userAPI.getUserByUsername(username);

    if (response['success'] == true) {
      var user = User.fromJson(response['data']);
      return ApiResult.success(user);
    } else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    } else {
      return ApiResult.failure('Unknown Error');
    }
  }

  // Get User by email and password
  Future<ApiResult> validateUserCredentials(
      String email, String password) async {
    var response = await _userAPI.validateUserCredentials(email, password);

    if (response['success'] == true) {
      var user = User.fromJson(response['data']['user']);
      Session.getInstance(currentUser: user);
      _sharedPrefsService.saveCurrentUserId(user.id!);
      return ApiResult.success(user);
    } else if (response['success'] == false) {
      return ApiResult.failure('Incorrect Email or password');
    } else {
      return ApiResult.failure('Unknown Error');
    }
  }

  // Method to update user information
  Future<ApiResult> updateUser(User user) async {
    var response = await _userAPI.updateUser(user);

    if (response['success'] == true) {
      var user = User.fromJson(response['data']);
      Session.getInstance().currentUser = user;
      return ApiResult.success(user);
    } else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    } else {
      return ApiResult.failure('Unknown Error');
    }
  }

  // Method to delete a user
  Future<String> deleteUser(int userId) async {
    var response = await _userAPI.deleteUser(userId);

    if (response['success'] == true) {
      return "User successfully deleted";
    } else if (response['success'] == false) {
      return "Failed to delete user";
    } else {
      return "Unknown error occurred";
    }
  }
}
