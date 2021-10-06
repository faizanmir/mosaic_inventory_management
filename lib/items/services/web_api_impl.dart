import 'dart:convert';
import 'package:mosaic_inventory_management/items/services/web_api.dart';
import 'package:mosaic_inventory_management/models/item.dart';
import 'package:mosaic_inventory_management/models/item_response.dart';
import 'package:mosaic_inventory_management/models/items_wrapper.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class ItemsWebApiImpl implements ItemsWebApi {
  @override
  Future<ItemWrapper> getItemsForCategory(int categoryId,
      {String? authToken}) async {
    final response = await http.get(
        Uri.parse(baseUrl + "/item/$categoryId/get-items-for-category-id/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$authToken"
        });
    print(response.body);
    if (response.statusCode == 200) {
      return ItemWrapper.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("item get encountered a problem ${response.body}");
    }
  }

  @override
  Future<ItemResponse> addItem(
      int itemCategoryId, String name, double rate, double count,
      {String? authToken}) async {
      final request = http.MultipartRequest(
          "POST", Uri.parse(baseUrl + "/item/$itemCategoryId/add-item"));
      request.headers.addAll({
        "Content-Type": "application/json",
        "Authorization": "$authToken"
      });
      request.fields.addAll({"name": name, "rate": "$rate", "count": "$count"});
      http.Response response = await http.Response.fromStream(
          await request.send());
      if(response.statusCode==200){
        return ItemResponse.fromMap(jsonDecode(response.body));
      }else{
        throw Exception("item add encountered a problem ${response.body}");
      }
  }

  @override
  Future<ItemResponse> deleteItem(int categoryId, int itemId,
      {String? authToken}) async {
    final response = await http.get(
        Uri.parse(baseUrl + "/item/$categoryId/get-items-for-category-id/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$authToken"
        });
    if (response.statusCode == 200) {
      return ItemResponse.fromMap(jsonDecode(response.body));
      ;
    } else {
      throw Exception("item del encountered a problem ${response.body}");
    }
  }

  @override
  Future<ItemResponse> updateItem(int itemCategoryId, int id, Item item,
      {String? authToken}) async {
    final response = await http.get(
        Uri.parse(baseUrl + "/item/$itemCategoryId/update-item/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$authToken"
        });
    if (response.statusCode == 200) {
      return ItemResponse.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("item update encountered a problem ${response.body}");
    }
  }
}
