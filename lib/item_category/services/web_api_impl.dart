import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mosaic_inventory_management/item_category/services/web.dart';
import 'package:mosaic_inventory_management/models/category_response.dart';
import 'package:mosaic_inventory_management/models/user_category_reponse.dart';

import '../../constants.dart';

class CategoryWebApiImpl extends CategoryWebApi {
  @override
  Future<UserCategoryResponse> getCategoriesForUser(
      {String? accessToken}) async {
    final response = await http
        .get(Uri.parse(baseUrl + "/category/get-all-categories"), headers: {
      "Content-Type": "application/json",
      "Authorization": "$accessToken"
    });

    print(response.body);

    if (response.statusCode == 200) {
      return UserCategoryResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Category fetch encountered a problem ${response.body}");
    }
  }

  @override
  Future<CategoryResponse> addCategory(String name, {String? authToken}) async {
    final response = await http.post(
        Uri.parse(baseUrl + "/category/add-category"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$authToken"
        },
        body: jsonEncode({"categoryName": name, "requiresAction": false}));
    if (response.statusCode == 200) {
      return CategoryResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Category add encountered a problem ${response.body}");
    }
  }

  @override
  Future<CategoryResponse> deleteCategory(int id, {String? authToken}) async {
    final response = await http
        .delete(Uri.parse(baseUrl + "/category/delete-category/$id"), headers: {
      "Content-Type": "application/json",
      "Authorization": "$authToken"
    });
    if (response.statusCode == 200) {
      return CategoryResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Category delete encountered a problem ${response.body}");
    }
  }
}
