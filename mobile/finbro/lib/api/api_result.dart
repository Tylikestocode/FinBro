import 'package:finbro/domain/user.dart';

class ApiResult<T> {
  final bool success;
  final T? data;
  final String? errorMessage;

  // Constructor for successful result
  ApiResult.success(this.data) : success = true, errorMessage = null;

  // Constructor for failure result
  ApiResult.failure(this.errorMessage) : success = false, data = null;
}
