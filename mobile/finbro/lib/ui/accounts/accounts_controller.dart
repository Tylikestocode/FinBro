import 'package:decimal/decimal.dart';
import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/account.dart';
import 'package:finbro/service/account_service.dart';
import 'package:finbro/service/shared_prefs_service.dart';
import 'package:finbro/service/user_service.dart';
import 'package:finbro/ui/components/snack_bar_message.dart';

class AccountsController {

  final sharedPrefService = SharedPrefsService();
  final userService = UserService();
  final accountService = AccountService();

  final SnackBarMessage _snackBarMessage = SnackBarMessage();

  List<Account> accountsList = [];

  Future<void> loadAccounts() async {

    int? currentUserId = await sharedPrefService.getCurrentUserId();
    ApiResult result = await accountService.getAllByUserId(currentUserId!);

    if (result.success) {
      accountsList = result.data;
    }

  }

  double getTotal() {

    double total = 0.0;

    for (Account account in accountsList) {
      total += account.balance!;
    }

    return total;

  }

}