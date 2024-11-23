import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/user.dart';
import 'package:finbro/service/user_service.dart';
import 'package:finbro/service/websocket_service.dart';
import 'package:flutter/cupertino.dart';

class RegisterPageController {
  final UserService userService = UserService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  final WebSocketService webSocketService = WebSocketService();

  Future<ApiResult> handleRegistration() async {
    String email = emailController.text.trim();
    String password = passwordController.text;
    String username = getUsernameFromEmail(email);

    User user = User(
        username: username,
        email: email,
        password: password,
        name: "",
        surname: "",
        age: 0);

    return await userService.createUser(user);
  }

  String? validateFields() {
    if (emailController.text.isEmpty) {
      return 'Please enter email';
    } else if (!_isValidEmail(emailController.text.trim())) {
      return 'Invalid email format';
    } else if (passwordController.text.isEmpty) {
      return 'Please enter password';
    // } else if (passwordController.text.length < 8) {
    //   return 'Password must contain at least 8 characters';
    } else if (confirmPasswordController.text.isEmpty) {
      return 'Please confirm password';
    } else if (passwordController.text != confirmPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  String getUsernameFromEmail(String email) {
    List<String> parts = email.split('@');
    return parts[0];
  }
}
