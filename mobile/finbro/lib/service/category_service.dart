import 'package:finbro/api/category_api.dart';
import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/category.dart';

class CategoryService {

  final CategoryAPI _categoryAPI = CategoryAPI();

  // Get all predefined Categories
  Future<ApiResult> getAllPredefinedCategories() async {

    var response = await _categoryAPI.getAllPredefinedCategories();

    if (response['success'] == true) {
      List<Category> allPredefinedCategories = (response['data'] as List)
          .map((categoryData) => Category.fromJson(categoryData))
          .toList();

      return ApiResult.success(allPredefinedCategories);
    }
    else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    }
    else {
      return ApiResult.failure('Failed to get all predefined Categories: getAllPredefinedCategories - CategoryService');
    }

  }

  // Get Category by Id
  Future<ApiResult> getByCategoryId(int categoryId) async {

    var response = await _categoryAPI.getbyCategoryId(categoryId);

    if (response['success'] == true) {
      Category category = Category.fromJson(response['data']);
      return ApiResult.success(category);
    }
    else if (response['success'] == false) {
      return ApiResult.failure(response['error']['details']);
    }
    else {
      return ApiResult.failure('Failed to get Category: getCategoryById - CategoryService');
    }

  }

}