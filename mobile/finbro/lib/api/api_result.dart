import 'package:finbro/domain/user.dart';

class ApiResult {

  final bool success;
  final User? user;
  final String? errorMessage;

  ApiResult.success(this.user) : success = true, errorMessage = null;
  ApiResult.failure(this.errorMessage) : success = false, user = null;

}