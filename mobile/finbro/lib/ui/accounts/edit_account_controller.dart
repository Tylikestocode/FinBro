import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/account.dart';
import 'package:finbro/service/account_service.dart';
import 'package:finbro/service/shared_prefs_service.dart';
import 'package:finbro/ui/components/snack_bar_message.dart';
import 'package:flutter/cupertino.dart';

class EditAccountController {
  final _accountService = AccountService();
  final _sharedPrefsService = SharedPrefsService();
  final _snackBarMessage = SnackBarMessage();

  Future<void> editAccount(BuildContext buildContext, int accountId,
      String accountName, double balance, int categoryId) async {
    int? userId = await _sharedPrefsService.getCurrentUserId();

    Account editedAccount = Account(
        id: accountId,
        name: accountName,
        balance: balance,
        userId: userId!,
        categoryId: categoryId);

    ApiResult result = await _accountService.updateAccount(editedAccount);
    if (result.success) {
      Navigator.pop(buildContext, true);
    } else {
      _snackBarMessage.showSnackBarMessage(buildContext, result.errorMessage!);
    }
  }

  Future<void> deleteAccount(BuildContext buildContext, int accountId) async {

    ApiResult result = await _accountService.deleteAccount(accountId);

    if (result.success) {
      Navigator.pop(buildContext, true);
    }
    else {
      _snackBarMessage.showSnackBarMessage(buildContext, "Error while trying to delete Account");
    }

  }

}
