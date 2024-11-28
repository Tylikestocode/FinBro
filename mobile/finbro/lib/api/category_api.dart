import 'dart:convert';

import 'package:finbro/api/api_constants.dart';
import 'package:http/http.dart' as http;

class CategoryAPI {

  final String apiUrl = '${ApiConstants.BASE_URL}/api/mobile/categories';

  // Get all predefined categories
  Future<Map<String, dynamic>> getAllPredefinedCategories() async {

    final response = await http.get(Uri.parse('$apiUrl/predefined'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else if (response.statusCode != 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed to get predefined Categories');
    }

  }

  // Get by Category Id
  Future<Map<String, dynamic>> getbyCategoryId(int categoryId) async {

    final response = await http.get(Uri.parse('$apiUrl/$categoryId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else if (response.statusCode != 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed to get Category by Id');
    }

  }

}