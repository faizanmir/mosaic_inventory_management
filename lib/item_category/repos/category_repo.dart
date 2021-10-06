import 'package:mosaic_inventory_management/auth_token_prefs/auth_token_mixin.dart';
import 'package:mosaic_inventory_management/models/category_response.dart';
import 'package:mosaic_inventory_management/models/user_category_reponse.dart';
import 'package:mosaic_inventory_management/item_category/services/web.dart';
import 'package:mosaic_inventory_management/services/service_locator.dart';

class CategoryRepository  extends CategoryWebApi with AuthTokenMixin{

  CategoryWebApi categoryWebApi =  serviceLocator<CategoryWebApi>();

  @override
  Future<UserCategoryResponse> getCategoriesForUser({String? accessToken}) async{
    String? token =await mGetAccessToken();
    return categoryWebApi.getCategoriesForUser(accessToken:token!);
  }

  @override
  Future<CategoryResponse> addCategory(String name, {String? authToken}) async {
    return categoryWebApi.addCategory(name,authToken: await mGetAccessToken());

  }

  @override
  Future<CategoryResponse> deleteCategory(int id,{String? authToken}) async{
   return categoryWebApi.deleteCategory(id,authToken: await mGetAccessToken());
  }


}