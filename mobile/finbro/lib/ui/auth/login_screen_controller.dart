import 'package:decimal/decimal.dart';
import 'package:finbro/api/account_api.dart';
import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/account.dart';
import 'package:finbro/service/account_service.dart';
import 'package:finbro/service/user_service.dart';
import 'package:finbro/service/websocket_service.dart';
import 'package:flutter/cupertino.dart';

class LoginPageController {
  final UserService userService = UserService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final WebSocketService webSocketService = WebSocketService();

  Future<ApiResult> handleLogin() async {

    String email = emailController.text.trim();
    String password = passwordController.text;

    return await userService.validateUserCredentials(email, password);
  }

  String? validateFields() {
    if (emailController.text.isEmpty) {
      return 'Please enter email';
    } else if (passwordController.text.isEmpty) {
      return 'please enter password';
    }
    return null;
  }
}
