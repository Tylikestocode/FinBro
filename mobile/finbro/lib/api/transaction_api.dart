import 'dart:convert';

import 'package:finbro/api/api_constants.dart';
import 'package:finbro/domain/account.dart';
import 'package:finbro/domain/transaction.dart';
import 'package:http/http.dart' as http;


class TransactionAPI {

  final String apiUrl = '${ApiConstants.BASE_URL}/api/mobile/transactions';

  // Create Transaction
  Future<Map<String, dynamic>> createTransaction(Transaction transaction) async {

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    else if (response.statusCode != 201) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed to create Transaction. Unknown error');
    }

  }
  
  // Get all Transactions by Account Id
  Future<Map<String, dynamic>> getAllByAccountId(int accountId) async {
    
    final response = await http.get(Uri.parse('$apiUrl/accountId/$accountId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else if (response.statusCode != 200) {
      return jsonDecode(response.body);
    }
    else{
      throw Exception('Failed to get Account Transactions');
    }
    
  }

}