import 'package:finbro/api/account_api.dart';
import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/account.dart';
import 'package:finbro/service/shared_prefs_service.dart';

class AccountService {

  final AccountApi _accountApi = AccountApi();
  final SharedPrefsService _sharedPrefsService = SharedPrefsService();

  // Create Account
  Future<ApiResult> createAccount(Account account) async {

    var response = await _accountApi.createAccount(account);

    if (response['success'] == true) {
      var account = Account.fromJson(response['data']);
      return ApiResult.success(account);
    }
    else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    }
    else {
      return ApiResult.failure('Failed to create Account: createAccount - AccountService');
    }

  }

  // Get Account by Id
  Future<ApiResult> getAccountById(int accountId) async {

    var response = await _accountApi.getAccountById(accountId);

    if (response['success'] == true) {
      var account = Account.fromJson(response['data']);
      return ApiResult.success(account);
    }
    else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    }
    else {
      return ApiResult.failure('Failed to get Account: getAccountById - AccountService');
    }

  }

  // Get all Accounts by User Id
  Future<ApiResult> getAllByUserId(int userId) async {

    var response = await _accountApi.getAllByUserId(userId);

    if (response['success'] == true) {
      List<Account> allUserAccounts = (response['data'] as List)
          .map((accountData) => Account.fromJson(accountData))
          .toList();

      return ApiResult.success(allUserAccounts);
    }
    else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    }
    else {
      return ApiResult.failure('Failed to get User\'s Accounts: getAllByUserId - AccountService');
    }

  }

  // Update Account
  Future<ApiResult> updateAccount(Account account) async {

    var response = await _accountApi.updateAccount(account);

    if (response['success'] == true) {
      Account account = Account.fromJson(response['data']);
      return ApiResult.success(account);
    }
    else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    }
    else {
      return ApiResult.failure('Failed to update Account: updateAccount - AccountService');
    }

  }

  // Delete Account
  Future<ApiResult> deleteAccount(int accountId) async {

    var response = await _accountApi.deleteAccount(accountId);

    if (response['success'] == true) {
      return ApiResult.success(null);
    }
    else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    }
    else {
      return ApiResult.failure('Failed to delete Account: deleteAccount - AccountService');
    }

  }

}