import 'dart:convert';

import 'package:finbro/api/api_constants.dart';
import 'package:finbro/domain/account.dart';
import 'package:http/http.dart' as http;


class AccountApi {

  final String apiUrl = '${ApiConstants.BASE_URL}/api/mobile/accounts';

  // Create Account
  Future<Map<String, dynamic>> createAccount(Account account) async {

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(account.toJson()),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    else if (response.statusCode != 201) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed to create Account. Unknown error');
    }

  }

  // Get Account by Id
  Future<Map<String, dynamic>> getAccountById(int accountId) async {

    final response = await http.get(Uri.parse('$apiUrl/$accountId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else if (response.statusCode != 200) {
      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      return errorResponse;
    }
    else {
      throw Exception('Failed to load Account');
    }

  }

  // Get all Accounts by User Id
  Future<Map<String, dynamic>> getAllByUserId(int userId) async {

    final response = await http.get(Uri.parse('$apiUrl/userId/$userId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else if (response.statusCode != 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed to get user Accounts');
    }

  }

  // Get Account by User Id and Name
  Future<Map<String, dynamic>> getByUserIdAndName(int userId, String accountName) async {

    final Uri uri = Uri.parse('$apiUrl/userId-and-name').replace(queryParameters: {
      'userId': userId.toString(),
      'accountName': accountName
    });
    
    final response = await http.get(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else if (response.statusCode != 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed to get Account by user Id and Account name');
    }

  }

  // Get number of accounts by User id and account name
  Future<Map<String, dynamic>> getCountByUserIdAndName(int userId, String accountName) async {
    
    final Uri uri = Uri.parse('$apiUrl/count-by-userId-and-name').replace(queryParameters: {
      'userId': userId.toString(),
      'accountName': accountName
    });

    final response = await http.get(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else if (response.statusCode != 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed to get total number of accounts by userId and account name');
    }

  }

  // Update Account
  Future<Map<String, dynamic>> updateAccount(Account account) async {

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(account.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else if (response.statusCode != 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed to update Account');
    }

  }

  // Delete Account by id
  Future<Map<String, dynamic>> deleteAccount(int accountId) async {

    final response = await http.delete(Uri.parse('$apiUrl/$accountId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else if (response.statusCode != 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed to delete Account');
    }

  }


}