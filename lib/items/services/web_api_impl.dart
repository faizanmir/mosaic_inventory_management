import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mosaic_inventory_management/items/services/web_api.dart';
import 'package:mosaic_inventory_management/models/item.dart';
import 'package:mosaic_inventory_management/models/item_response.dart';
import 'package:mosaic_inventory_management/models/items_wrapper.dart';
import 'package:mosaic_inventory_management/services/item_mixin.dart';

import '../../constants.dart';

class ItemsWebApiImpl with ItemActionsMixin implements ItemsWebApi  {
  @override
  Future<ItemWrapper> getItemsForCategory(int categoryId,
      {String? authToken}) async {
    final response = await http.get(
        Uri.parse(baseUrl + "/item/$categoryId/get-items-for-category-id/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$authToken"
        });

    debugPrint(response.body);
    if (response.statusCode == 200) {
      return ItemWrapper.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("Item get encountered a problem ${response.body}");
    }
  }

  @override
  Future<ItemResponse> addItem(
      int itemCategoryId, String name, double rate, double count, {String? authToken}) async {
      return mAddItem(itemCategoryId, name, rate, count, authToken);
  }

  @override
  Future<ItemResponse> deleteItem(int categoryId, int itemId,
      {String? authToken}) async {
    return mDeleteItem(categoryId, itemId,authToken: authToken);
  }

  @override
  Future<ItemResponse> updateItem(int itemCategoryId, int id, Item item,
      {String? authToken}) async {
    return mUpdateItem(itemCategoryId, id, item,authToken: authToken);
  }


}
