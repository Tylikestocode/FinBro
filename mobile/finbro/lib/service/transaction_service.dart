import 'package:finbro/api/api_result.dart';
import 'package:finbro/api/transaction_api.dart';
import 'package:finbro/domain/account.dart';
import 'package:finbro/domain/transaction.dart';

class TransactionService {

  final TransactionAPI _transactionAPI = TransactionAPI();

  // Create Transaction
  Future<ApiResult> createTransaction(Transaction transaction) async {

    var response = await _transactionAPI.createTransaction(transaction);

    if (response['success'] == true) {
      Transaction transaction = Transaction.fromJson(response['data']);
      return ApiResult.success(transaction);
    }
    else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    }
    else {
      return ApiResult.failure('Failed to create Transaction: createTransaction - TransactionService');
    }

  }

  // Get all by Account id
  Future<ApiResult> getAllByAccountId(int accountId) async {

    var response = await _transactionAPI.getAllByAccountId(accountId);

    if (response['success'] == true) {
      List<Transaction> allAccountTransactions = (response['data'] as List)
          .map((transactionData) => Transaction.fromJson(transactionData))
          .toList();

      return ApiResult.success(allAccountTransactions);
    }
    else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    }
    else {
      return ApiResult.failure('Failed to get Account Transaction: getAllByAccountId - TransactionService');
    }

  }

}