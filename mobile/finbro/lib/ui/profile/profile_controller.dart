import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/user.dart';
import 'package:finbro/service/shared_prefs_service.dart';
import 'package:finbro/service/user_service.dart';
import 'package:finbro/ui/auth/login_screen.dart';
import 'package:finbro/ui/components/snack_bar_message.dart';
import 'package:finbro/ui/profile/edit_attribute_screen.dart';
import 'package:finbro/ui/profile/password_edit_screen.dart';
import 'package:flutter/material.dart';

class ProfileController {
  final sharedPrefsService = SharedPrefsService();
  final userService = UserService();

  final SnackBarMessage _snackBarMessage = SnackBarMessage();

  String firstName = '';
  String lastName = '';
  String username = '';
  String email = '';

  Future<void> loadUser() async {
    int? currentUserId = await sharedPrefsService.getCurrentUserId();
    ApiResult result = await userService.getUserById(currentUserId!);
    User? user;
    if (result.success) {
      user = result.user!;
      if (user.name != null) {
        firstName = user.name!;
      }
      if (user.surname != null) {
        lastName = user.surname!;
      }
      username = user.username;
      email = user.email;
    }
  }

  Future<void> logout(BuildContext buildContext) async {
    await sharedPrefsService.deleteCurrentUserId();
    if (buildContext.mounted) {
      Navigator.pushAndRemoveUntil(
          buildContext,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    }
  }

  Future<void> deleteAccount(BuildContext buildContext) async {

    int? currentUserId = await sharedPrefsService.getCurrentUserId();
    if (currentUserId != null) {
      String message = await userService.deleteUser(currentUserId);
      await sharedPrefsService.deleteCurrentUserId();
      if (buildContext.mounted) {
        _snackBarMessage.showSnackBarMessage(buildContext, message);
        Navigator.pushAndRemoveUntil(
            buildContext,
            MaterialPageRoute(builder: (buildContext) => const LoginScreen()),
            (route) => false,
        );
      }
    }

  }

  Future<void> navigateToEditScreen(BuildContext buildContext, String title,
      String attribute, String value) async {
    final result = await Navigator.push(
      buildContext,
      MaterialPageRoute(
        builder: (context) => EditAttributeScreen(
          title: title,
          attributeLabel: attribute,
          initialValue: value,
        ),
      ),
    );

    if (result != null) {
      // Update the corresponding field with the returned value
      switch (attribute) {
        case 'First Name':
          firstName = result;
          break;
        case 'Last Name':
          lastName = result;
          break;
        case 'Username':
          username = result;
          break;
        case 'Email':
          email = result;
          break;
        case 'Password':
          break;
      }
    }
  }

  Future<void> navigateToPasswordEditScreen(BuildContext buildContext) async {

    final result = await Navigator.push(
        (buildContext),
        MaterialPageRoute(builder: (context) => const PasswordEditScreen())
    );

    if (buildContext.mounted) {
      if (result) {
        _snackBarMessage.showSnackBarMessage(buildContext, 'Password changed successfully');
      }
      else {
        _snackBarMessage.showSnackBarMessage(buildContext, 'Error trying to change password');
      }
    }
  }
}
