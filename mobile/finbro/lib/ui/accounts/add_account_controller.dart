import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/account.dart';
import 'package:finbro/service/account_service.dart';
import 'package:finbro/service/shared_prefs_service.dart';
import 'package:finbro/service/user_service.dart';
import 'package:finbro/ui/components/snack_bar_message.dart';
import 'package:flutter/cupertino.dart';

class AddAccountController {

  final AccountService _accountService = AccountService();
  final UserService _userService = UserService();
  final SharedPrefsService _sharedPrefsService = SharedPrefsService();
  final SnackBarMessage _snackBarMessage = SnackBarMessage();

  Future<void> createAccount (
      BuildContext buildContext, String accountName, double balance, int categoryId) async {

    int? userId = await _sharedPrefsService.getCurrentUserId();

    Account newAccount = Account(
        name: accountName,
        balance: balance,
        userId: userId!,
        categoryId: categoryId
    );

    ApiResult result = await _accountService.createAccount(newAccount);
    if (result.success) {
      Navigator.pop(buildContext, true);
    }
    else {
      _snackBarMessage.showSnackBarMessage(buildContext, result.errorMessage!);
    }
  }

}
