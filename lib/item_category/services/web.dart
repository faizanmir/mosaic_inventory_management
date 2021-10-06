import 'package:mosaic_inventory_management/models/category_response.dart';
import 'package:mosaic_inventory_management/models/user_category_reponse.dart';

abstract class CategoryWebApi{
  Future<UserCategoryResponse> getCategoriesForUser({String accessToken});
  Future<CategoryResponse> addCategory(String name,{String? authToken});
  Future<CategoryResponse> deleteCategory(int id,{String? authToken});
}